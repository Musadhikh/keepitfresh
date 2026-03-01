//
//  InventoryRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares remote inventory mutation operations used by offline-first sync flows.
//

import Foundation

public protocol InventoryRemoteGateway: Sendable {
    func upsert(_ items: [InventoryItem]) async throws
    func fetchActiveItems(householdId: String) async throws -> [InventoryItem]
    /// Returns a household snapshot used for refresh reconciliation.
    /// Contract: omitted item IDs MUST NOT be treated as hard-delete tombstones by callers.
    /// Deletion semantics are archive-first via explicit status transitions.
    func fetchItemsSnapshot(householdId: String) async throws -> [InventoryItem]
}

public extension InventoryRemoteGateway {
    func fetchItemsSnapshot(householdId: String) async throws -> [InventoryItem] {
        try await fetchActiveItems(householdId: householdId)
    }
}
