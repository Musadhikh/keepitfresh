//
//  StubInventoryModuleRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Temporary remote gateway adapter for InventoryModule until concrete backend APIs are finalized.
//

import Foundation
import InventoryModule


actor StubInventoryModuleRemoteGateway: InventoryModuleTypes.InventoryRemoteGateway {
    private var remoteStorage: [String: InventoryModuleTypes.InventoryItem] = [:]

    func upsert(_ items: [InventoryModuleTypes.InventoryItem]) async throws {
        for item in items {
            remoteStorage[item.id] = item
        }
    }

    func fetchActiveItems(householdId: String) async throws -> [InventoryModuleTypes.InventoryItem] {
        remoteStorage.values
            .filter { $0.householdId == householdId && $0.status == .active }
            .sorted { $0.createdAt < $1.createdAt }
    }
}
