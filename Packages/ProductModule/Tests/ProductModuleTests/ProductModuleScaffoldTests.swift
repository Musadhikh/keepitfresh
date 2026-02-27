//
//  ProductModuleScaffoldTests.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Verifies scaffolded product application behavior and identity invariants.
//

import Foundation
import XCTest
@testable import ProductModule

final class ProductModuleScaffoldTests: XCTestCase {
    func test_addProducts_rejectsBarcodeAndProductIDMismatch() async throws {
        let local = LocalStoreStub()
        let remote = RemoteGatewayStub()
        let syncStore = SyncStoreStub()
        let service = DefaultProductModuleService(
            localStore: local,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: OfflineConnectivityProvider()
        )

        let product = Product(
            productId: "1234",
            barcode: Barcode(value: "9999", symbology: .ean13)
        )

        do {
            _ = try await service.addProducts([product])
            XCTFail("Expected identity mismatch error")
        } catch let error as ProductModuleError {
            XCTAssertEqual(
                error,
                .productIDMustMatchBarcode(productID: "1234", normalizedBarcode: "9999")
            )
        }
    }

    func test_retrieveProduct_localMissRemoteHit_cachesLocally() async throws {
        let local = LocalStoreStub()
        let remote = RemoteGatewayStub()
        let syncStore = SyncStoreStub()
        let service = DefaultProductModuleService(
            localStore: local,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: OnlineConnectivityProvider()
        )

        let product = Product(
            productId: "0123456789012",
            barcode: Barcode(value: "0123456789012", symbology: .ean13),
            title: "Milk"
        )
        await remote.seed(product: product)

        let loaded = try await service.retrieveProduct(by: .productId("0123456789012"))

        XCTAssertEqual(loaded?.productId, product.productId)
        let cached = try await local.get(productId: product.productId)
        XCTAssertEqual(cached?.productId, product.productId)
    }

    func test_retrieveProduct_localMissOffline_throwsConnectivityError() async throws {
        let local = LocalStoreStub()
        let remote = RemoteGatewayStub()
        let syncStore = SyncStoreStub()
        let service = DefaultProductModuleService(
            localStore: local,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: OfflineConnectivityProvider()
        )

        do {
            _ = try await service.retrieveProduct(by: .productId("0123456789012"))
            XCTFail("Expected offline connectivity error")
        } catch let error as ProductModuleError {
            XCTAssertEqual(error, .connectivityUnavailable(operation: .retrieveProduct))
        }
    }

    func test_retrieveProducts_localEmptyOffline_throwsConnectivityError() async throws {
        let local = LocalStoreStub()
        let remote = RemoteGatewayStub()
        let syncStore = SyncStoreStub()
        let service = DefaultProductModuleService(
            localStore: local,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: OfflineConnectivityProvider()
        )

        do {
            _ = try await service.retrieveProducts(query: ProductQuery())
            XCTFail("Expected offline connectivity error")
        } catch let error as ProductModuleError {
            XCTAssertEqual(error, .connectivityUnavailable(operation: .retrieveProducts))
        }
    }

    func test_syncPending_offline_throwsConnectivityError() async throws {
        let local = LocalStoreStub()
        let remote = RemoteGatewayStub()
        let syncStore = SyncStoreStub()
        let service = DefaultProductModuleService(
            localStore: local,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: OfflineConnectivityProvider()
        )

        do {
            _ = try await service.syncPending(limit: nil)
            XCTFail("Expected offline connectivity error")
        } catch let error as ProductModuleError {
            XCTAssertEqual(error, .connectivityUnavailable(operation: .syncPending))
        }
    }
}

private actor LocalStoreStub: ProductLocalStore {
    private var byID: [String: Product] = [:]

    func get(productId: String) async throws -> Product? {
        byID[productId]
    }

    func getByBarcode(_ barcode: String) async throws -> Product? {
        byID.values.first { $0.barcode?.value == barcode }
    }

    func getMany(productIDs: [String]) async throws -> [Product] {
        productIDs.compactMap { byID[$0] }
    }

    func query(_ query: ProductQuery) async throws -> ProductPage {
        let items = byID.values.sorted { $0.productId < $1.productId }
        return ProductPage(items: items)
    }

    func upsert(_ products: [Product], syncState: ProductSyncState) async throws {
        for product in products {
            byID[product.productId] = product
        }
    }

    func delete(productIDs: [String]) async throws {
        for id in productIDs {
            byID[id] = nil
        }
    }
}

private actor RemoteGatewayStub: ProductRemoteGateway {
    private var byID: [String: Product] = [:]

    func seed(product: Product) {
        byID[product.productId] = product
    }

    func fetch(productId: String) async throws -> Product? {
        byID[productId]
    }

    func fetchByBarcode(_ barcode: String) async throws -> Product? {
        byID.values.first { $0.barcode?.value == barcode }
    }

    func query(_ query: ProductQuery) async throws -> ProductPage {
        ProductPage(items: Array(byID.values))
    }

    func upsert(_ products: [Product]) async throws {
        for product in products {
            byID[product.productId] = product
        }
    }

    func delete(productIDs: [String]) async throws {
        for id in productIDs {
            byID[id] = nil
        }
    }
}

private actor SyncStoreStub: ProductSyncStateStore {
    private var byID: [String: ProductSyncMetadata] = [:]

    func fetchMetadata(productIDs: [String]) async throws -> [ProductSyncMetadata] {
        productIDs.compactMap { byID[$0] }
    }

    func upsertMetadata(_ metadata: [ProductSyncMetadata]) async throws {
        for item in metadata {
            byID[item.productId] = item
        }
    }

    func listPendingProductIDs(limit: Int?) async throws -> [String] {
        let pending = byID.values.filter { metadata in
            switch metadata.state {
            case .pendingUpsert, .pendingDelete:
                return true
            case .synced, .failed:
                return false
            }
        }
        .map(\.productId)

        if let limit {
            return Array(pending.prefix(limit))
        }

        return pending
    }
}

private struct OnlineConnectivityProvider: ConnectivityProviding {
    func isOnline() async -> Bool { true }
}

private struct OfflineConnectivityProvider: ConnectivityProviding {
    func isOnline() async -> Bool { false }
}
