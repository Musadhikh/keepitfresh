//
//  InventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Inventory persistence contract for local-first add-product flow.
//

import Foundation

enum InventorySyncOperation: Sendable, Hashable, Codable {
    case upsertInventory(InventoryItem)
}

enum InventoryRepositoryError: Error, Sendable {
    case remoteUnavailable
    case householdMissing
    case unknown
}

protocol InventoryRepository: Sendable {
    func findLocal(householdId: String, barcode: Barcode) async throws -> InventoryItem?
    func findRemote(householdId: String, barcode: Barcode) async throws -> InventoryItem?
    func fetchAllLocal(householdId: String?) async throws -> [InventoryItem]

    func upsertLocal(_ item: InventoryItem) async throws
    func upsertRemote(_ item: InventoryItem) async throws

    func enqueueSync(_ operation: InventorySyncOperation) async
}
