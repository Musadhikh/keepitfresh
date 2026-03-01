//
//  SyncPendingInventoryUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for syncing pending inventory mutations to remote.
//

import Foundation
import InventoryDomain

public struct SyncPendingInventoryInput: Sendable, Equatable {
    public var householdId: String
    public var limit: Int?
    public var operations: Set<InventorySyncOperation>?

    public init(
        householdId: String,
        limit: Int? = nil,
        operations: Set<InventorySyncOperation>? = nil
    ) {
        self.householdId = householdId
        self.limit = limit
        self.operations = operations
    }
}

public struct SyncPendingInventoryOutput: Sendable, Equatable {
    public var syncedCount: Int
    public var failedCount: Int
    public var skippedCount: Int
    public var failedItemIDs: [String]

    public init(
        syncedCount: Int,
        failedCount: Int,
        skippedCount: Int,
        failedItemIDs: [String]
    ) {
        self.syncedCount = syncedCount
        self.failedCount = failedCount
        self.skippedCount = skippedCount
        self.failedItemIDs = failedItemIDs
    }
}

public protocol SyncPendingInventoryUseCase: Sendable {
    func execute(_ input: SyncPendingInventoryInput) async throws -> SyncPendingInventoryOutput
}
