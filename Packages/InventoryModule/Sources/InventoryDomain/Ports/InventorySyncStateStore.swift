//
//  InventorySyncStateStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares sync metadata persistence operations for inventory mutation tracking.
//

import Foundation

public protocol InventorySyncStateStore: Sendable {
    func upsertMetadata(_ metadata: [InventorySyncMetadata]) async throws
    func fetchByState(
        householdId: String,
        state: InventorySyncState,
        limit: Int?
    ) async throws -> [InventorySyncMetadata]
    func metadata(
        for itemId: String,
        householdId: String,
        operation: InventorySyncOperation
    ) async throws -> InventorySyncMetadata?
    func metadata(
        forRequestId requestId: String,
        householdId: String,
        operation: InventorySyncOperation
    ) async throws -> InventorySyncMetadata?
}
