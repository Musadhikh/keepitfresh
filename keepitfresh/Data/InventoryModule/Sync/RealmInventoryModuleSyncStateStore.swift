//
//  RealmInventoryModuleSyncStateStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Realm-backed sync metadata store adapter for InventoryModule.
//

import Foundation
import InventoryModule
import RealmDatabaseModule

typealias IMSyncMetadata = InventoryModuleTypes.InventorySyncMetadata
typealias IMSyncOperation = InventoryModuleTypes.InventorySyncOperation
typealias IMSyncState = InventoryModuleTypes.InventorySyncState

private enum InventoryModuleSyncRealmNamespace {
    static let syncMetadata = "inventory_module_sync_metadata"
}

actor RealmInventoryModuleSyncStateStore: InventoryModuleTypes.InventorySyncStateStore {
    private let repository: RealmCodableRepository<IMSyncMetadata>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: InventoryModuleSyncRealmNamespace.syncMetadata,
            configuration: configuration,
            keyForModel: { record in
                Self.compositeKey(
                    itemId: record.itemId,
                    householdId: record.householdId,
                    operation: record.operation
                )
            }
        )
    }

    func upsertMetadata(_ metadata: [IMSyncMetadata]) async throws {
        for item in metadata {
            try await repository.upsert(item)
        }
    }

    func fetchByState(householdId: String, state: IMSyncState, limit: Int?) async throws -> [IMSyncMetadata] {
        let all = try await repository.fetchAll()
            .filter { $0.householdId == householdId && $0.state == state }
            .sorted { ($0.lastAttemptAt ?? .distantPast) < ($1.lastAttemptAt ?? .distantPast) }

        guard let limit, limit > 0 else {
            return all
        }
        return Array(all.prefix(limit))
    }

    func metadata(
        for itemId: String,
        householdId: String,
        operation: IMSyncOperation
    ) async throws -> IMSyncMetadata? {
        try await repository.fetch(
            primaryKey: Self.compositeKey(
                itemId: itemId,
                householdId: householdId,
                operation: operation
            )
        )
    }

    func metadata(
        forRequestId requestId: String,
        householdId: String,
        operation: IMSyncOperation
    ) async throws -> IMSyncMetadata? {
        guard requestId.isEmpty == false else {
            return nil
        }
        let all = try await repository.fetchAll()
        return all.first {
            $0.householdId == householdId &&
                $0.operation == operation &&
                $0.idempotencyRequestId == requestId
        }
    }
}

private extension RealmInventoryModuleSyncStateStore {
    static func compositeKey(itemId: String, householdId: String, operation: IMSyncOperation) -> String {
        "\(householdId)|\(operation.rawValue)|\(itemId)"
    }
}
