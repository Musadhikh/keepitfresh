//
//  RealmInventoryModuleWarmupRunStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Realm-backed launch warm-up run tracking store for InventoryModule.
//

import Foundation
import InventoryModule
import RealmDatabaseModule

private struct InventoryWarmupRunRecord: Codable, Sendable {
    var key: String
    var markedAt: Date
}

private enum InventoryModuleWarmupRealmNamespace {
    static let runs = "inventory_module_warmup_runs"
}


actor RealmInventoryModuleWarmupRunStore: InventoryModuleTypes.InventoryWarmupRunStore {
    private let repository: RealmCodableRepository<InventoryWarmupRunRecord>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: InventoryModuleWarmupRealmNamespace.runs,
            configuration: configuration,
            keyForModel: { $0.key }
        )
    }

    func hasRun(launchId: String, householdId: String, windowDays: Int) async throws -> Bool {
        let key = Self.makeKey(launchId: launchId, householdId: householdId, windowDays: windowDays)
        return try await repository.fetch(primaryKey: key) != nil
    }

    func markRun(launchId: String, householdId: String, windowDays: Int) async throws {
        let key = Self.makeKey(launchId: launchId, householdId: householdId, windowDays: windowDays)
        try await repository.upsert(
            InventoryWarmupRunRecord(
                key: key,
                markedAt: Date()
            )
        )
    }
}

private extension RealmInventoryModuleWarmupRunStore {
    static func makeKey(launchId: String, householdId: String, windowDays: Int) -> String {
        "\(launchId)|\(householdId)|\(windowDays)"
    }
}
