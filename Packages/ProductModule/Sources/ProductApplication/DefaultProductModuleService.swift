//
//  DefaultProductModuleService.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Provides default offline-first product orchestration using injected local/remote ports.
//

import Foundation
import ProductDomain

public actor DefaultProductModuleService: ProductModuleServicing {
    private let localStore: any ProductLocalStore
    private let remoteGateway: any ProductRemoteGateway
    private let syncStateStore: any ProductSyncStateStore
    private let connectivity: any ConnectivityProviding
    private let clock: any ClockProviding
    private let strategy: ProductSyncStrategy

    public init(
        localStore: any ProductLocalStore,
        remoteGateway: any ProductRemoteGateway,
        syncStateStore: any ProductSyncStateStore,
        connectivity: any ConnectivityProviding,
        clock: any ClockProviding = SystemClock(),
        strategy: ProductSyncStrategy = .offlineFirstDefault
    ) {
        self.localStore = localStore
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
        self.strategy = strategy
    }

    public func retrieveProduct(by lookup: ProductLookup) async throws -> Product? {
        let normalizedLookup = try normalizeLookup(lookup)
        if let local = try await loadLocal(lookup: normalizedLookup) {
            if shouldRefreshLocalHit {
                Task { [normalizedLookup] in
                    try? await self.refreshFromRemote(lookup: normalizedLookup)
                }
            }
            return local
        }

        if strategy.readPolicy == .localOnly {
            return nil
        }

        guard await connectivity.isOnline() else {
            throw ProductModuleError.connectivityUnavailable(operation: .retrieveProduct)
        }

        let remote = try await loadRemote(lookup: normalizedLookup)
        if let remote {
            try await persist(products: [remote], state: .synced)
        }

        return remote
    }

    public func retrieveProducts(query: ProductQuery) async throws -> ProductPage {
        let localPage = try await localStore.query(query)
        if localPage.items.isEmpty {
            if strategy.readPolicy == .localOnly {
                return localPage
            }

            guard await connectivity.isOnline() else {
                throw ProductModuleError.connectivityUnavailable(operation: .retrieveProducts)
            }

            let remotePage = try await remoteGateway.query(query)
            if remotePage.items.isEmpty == false {
                try await persist(products: remotePage.items, state: .synced)
            }
            return remotePage
        }

        if shouldRefreshLocalHit {
            Task { [query] in
                try? await self.refreshPageFromRemote(query: query)
            }
        }

        return localPage
    }

    public func addProducts(_ products: [Product]) async throws -> AddProductsResult {
        let outcome = try await write(products)
        return AddProductsResult(
            productIDs: outcome.productIDs,
            syncedCount: outcome.syncedCount,
            pendingCount: outcome.pendingCount
        )
    }

    public func updateProducts(_ products: [Product]) async throws -> UpdateProductsResult {
        let outcome = try await write(products)
        return UpdateProductsResult(
            productIDs: outcome.productIDs,
            syncedCount: outcome.syncedCount,
            pendingCount: outcome.pendingCount
        )
    }

    public func syncPending(limit: Int?) async throws -> SyncPendingResult {
        guard await connectivity.isOnline() else {
            throw ProductModuleError.connectivityUnavailable(operation: .syncPending)
        }

        let pendingIDs = try await syncStateStore.listPendingProductIDs(limit: limit)
        guard pendingIDs.isEmpty == false else {
            return SyncPendingResult(attemptedCount: 0, syncedCount: 0, failedCount: 0)
        }

        let products = try await localStore.getMany(productIDs: pendingIDs)
        guard products.isEmpty == false else {
            return SyncPendingResult(attemptedCount: pendingIDs.count, syncedCount: 0, failedCount: pendingIDs.count)
        }

        do {
            try await remoteGateway.upsert(products)
            try await persist(products: products, state: .synced)
            return SyncPendingResult(
                attemptedCount: products.count,
                syncedCount: products.count,
                failedCount: 0
            )
        } catch {
            let failedMetadata = metadata(for: products, state: .failed(retryCount: 1, lastError: error.localizedDescription, nextRetryAt: nil))
            try await syncStateStore.upsertMetadata(failedMetadata)
            return SyncPendingResult(
                attemptedCount: products.count,
                syncedCount: 0,
                failedCount: products.count
            )
        }
    }
}

private extension DefaultProductModuleService {
    var shouldRefreshLocalHit: Bool {
        switch strategy.readPolicy {
        case .localOnly:
            return false
        case .localThenRemoteIfStale, .localThenRemoteAlwaysBackground:
            return true
        }
    }

    func write(_ products: [Product]) async throws -> (productIDs: [String], syncedCount: Int, pendingCount: Int) {
        let validated = try validateIdentities(products)
        try await persist(products: validated, state: .pendingUpsert)

        guard strategy.writePolicy == .localThenRemoteImmediate, await connectivity.isOnline() else {
            return (validated.map(\.productId), 0, validated.count)
        }

        do {
            try await remoteGateway.upsert(validated)
            try await persist(products: validated, state: .synced)
            return (validated.map(\.productId), validated.count, 0)
        } catch {
            let failedMetadata = metadata(
                for: validated,
                state: .failed(retryCount: 1, lastError: error.localizedDescription, nextRetryAt: nil)
            )
            try await syncStateStore.upsertMetadata(failedMetadata)
            return (validated.map(\.productId), 0, validated.count)
        }
    }

    func validateIdentities(_ products: [Product]) throws -> [Product] {
        try products.map { product in
            let normalizedProductID = ProductIdentity.normalizedProductID(from: product.productId)
            guard normalizedProductID.isEmpty == false else {
                throw ProductModuleError.emptyProductID
            }

            var normalized = product
            if let barcode = ProductIdentity.normalizeBarcode(product.barcode?.value) {
                if barcode != normalizedProductID {
                    throw ProductModuleError.productIDMustMatchBarcode(
                        productID: normalizedProductID,
                        normalizedBarcode: barcode
                    )
                }
                normalized.barcode?.value = barcode
            }

            return normalized
        }
    }

    func normalizeLookup(_ lookup: ProductLookup) throws -> ProductLookup {
        switch lookup {
        case .productId(let productID):
            let normalizedProductID = ProductIdentity.normalizedProductID(from: productID)
            guard normalizedProductID.isEmpty == false else {
                throw ProductModuleError.emptyProductID
            }
            return .productId(normalizedProductID)

        case .barcode(let barcode):
            guard let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode) else {
                throw ProductModuleError.invalidBarcode
            }
            return .barcode(normalizedBarcode)
        }
    }

    func loadLocal(lookup: ProductLookup) async throws -> Product? {
        switch lookup {
        case .productId(let productID):
            return try await localStore.get(productId: productID)
        case .barcode(let barcode):
            return try await localStore.getByBarcode(barcode)
        }
    }

    func loadRemote(lookup: ProductLookup) async throws -> Product? {
        switch lookup {
        case .productId(let productID):
            return try await remoteGateway.fetch(productId: productID)
        case .barcode(let barcode):
            return try await remoteGateway.fetchByBarcode(barcode)
        }
    }

    func refreshFromRemote(lookup: ProductLookup) async throws {
        guard await connectivity.isOnline() else { return }
        guard let remote = try await loadRemote(lookup: lookup) else { return }
        try await persist(products: [remote], state: .synced)
    }

    func refreshPageFromRemote(query: ProductQuery) async throws {
        guard await connectivity.isOnline() else { return }
        let remotePage = try await remoteGateway.query(query)
        guard remotePage.items.isEmpty == false else { return }
        try await persist(products: remotePage.items, state: .synced)
    }

    func persist(products: [Product], state: ProductSyncState) async throws {
        try await localStore.upsert(products, syncState: state)
        try await syncStateStore.upsertMetadata(metadata(for: products, state: state))
    }

    func metadata(for products: [Product], state: ProductSyncState) -> [ProductSyncMetadata] {
        let now = clock.now()

        return products.map { product in
            switch state {
            case .synced:
                return ProductSyncMetadata(
                    productId: product.productId,
                    state: state,
                    lastAttemptAt: now,
                    lastSyncedAt: now,
                    retryCount: 0,
                    lastError: nil
                )

            case .pendingUpsert, .pendingDelete:
                return ProductSyncMetadata(
                    productId: product.productId,
                    state: state,
                    lastAttemptAt: now,
                    lastSyncedAt: nil,
                    retryCount: 0,
                    lastError: nil
                )

            case .failed(let retryCount, let lastError, _):
                return ProductSyncMetadata(
                    productId: product.productId,
                    state: state,
                    lastAttemptAt: now,
                    lastSyncedAt: nil,
                    retryCount: retryCount,
                    lastError: lastError
                )
            }
        }
    }
}
