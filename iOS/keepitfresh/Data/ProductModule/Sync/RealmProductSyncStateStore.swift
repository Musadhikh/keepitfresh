//
//  RealmProductSyncStateStore.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Persists ProductModule sync metadata in Realm and exposes pending sync lookup APIs.
//

import Foundation
import ProductModule
import RealmDatabaseModule

typealias PMSyncStoreProductSyncMetadata = ProductModuleTypes.ProductSyncMetadata

private enum ProductModuleRealmNamespace {
    static let syncMetadata = "product_module_sync_metadata"
}

actor RealmProductSyncStateStore: ProductSyncStateStore {
    private let repository: RealmCodableRepository<PMSyncStoreProductSyncMetadata>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: ProductModuleRealmNamespace.syncMetadata,
            configuration: configuration,
            keyForModel: { $0.productId }
        )
    }

    func fetchMetadata(productIDs: [String]) async throws -> [PMSyncStoreProductSyncMetadata] {
        guard productIDs.isEmpty == false else {
            return []
        }

        var metadata: [PMSyncStoreProductSyncMetadata] = []
        metadata.reserveCapacity(productIDs.count)

        for productID in productIDs {
            guard let item = try await repository.fetch(primaryKey: productID) else { continue }
            metadata.append(item)
        }

        return metadata
    }

    func upsertMetadata(_ metadata: [PMSyncStoreProductSyncMetadata]) async throws {
        for item in metadata {
            try await repository.upsert(item)
        }
    }

    func listPendingProductIDs(limit: Int?) async throws -> [String] {
        let allMetadata = try await repository.fetchAll()
        let pendingProductIDs = allMetadata
            .filter { metadata in
                switch metadata.state {
                case .pendingUpsert, .pendingDelete:
                    return true
                case .synced, .failed:
                    return false
                }
            }
            .sorted { lhs, rhs in
                let lhsDate = lhs.lastAttemptAt ?? .distantPast
                let rhsDate = rhs.lastAttemptAt ?? .distantPast

                if lhsDate != rhsDate {
                    return lhsDate < rhsDate
                }
                return lhs.productId < rhs.productId
            }
            .map(\.productId)

        guard let limit else {
            return pendingProductIDs
        }

        let safeLimit = max(0, limit)
        return Array(pendingProductIDs.prefix(safeLimit))
    }
}
