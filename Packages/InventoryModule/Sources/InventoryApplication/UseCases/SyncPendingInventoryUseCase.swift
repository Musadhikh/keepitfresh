//
//  SyncPendingInventoryUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for syncing pending inventory mutations to remote.
//

import Foundation

public struct SyncPendingInventoryInput: Sendable, Equatable {
    public var householdId: String
    public var limit: Int?

    public init(householdId: String, limit: Int? = nil) {
        self.householdId = householdId
        self.limit = limit
    }
}

public struct SyncPendingInventoryOutput: Sendable, Equatable {
    public var syncedCount: Int
    public var failedCount: Int
    public var skippedCount: Int

    public init(syncedCount: Int, failedCount: Int, skippedCount: Int) {
        self.syncedCount = syncedCount
        self.failedCount = failedCount
        self.skippedCount = skippedCount
    }
}

public protocol SyncPendingInventoryUseCase: Sendable {
    func execute(_ input: SyncPendingInventoryInput) async throws -> SyncPendingInventoryOutput
}

