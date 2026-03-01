//
//  InventorySync.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines sync metadata and operation states for offline-first inventory mutations.
//

import Foundation

public enum InventorySyncOperation: String, Sendable, Codable, Equatable, Hashable {
    case add
    case update
    case delete
    case consume
}

public enum InventorySyncState: String, Sendable, Codable, Equatable, Hashable {
    case pending
    case synced
    case failed
}

public struct InventorySyncMetadata: Sendable, Codable, Equatable, Hashable {
    public var itemId: String
    public var householdId: String
    public var operation: InventorySyncOperation
    public var state: InventorySyncState
    public var retryCount: Int
    public var lastError: String?
    public var lastAttemptAt: Date?
    public var lastSyncedAt: Date?
    public var idempotencyRequestId: String?
    public var addAction: InventoryAddAction?

    public init(
        itemId: String,
        householdId: String,
        operation: InventorySyncOperation,
        state: InventorySyncState,
        retryCount: Int,
        lastError: String?,
        lastAttemptAt: Date?,
        lastSyncedAt: Date?,
        idempotencyRequestId: String?,
        addAction: InventoryAddAction?
    ) {
        self.itemId = itemId
        self.householdId = householdId
        self.operation = operation
        self.state = state
        self.retryCount = retryCount
        self.lastError = lastError
        self.lastAttemptAt = lastAttemptAt
        self.lastSyncedAt = lastSyncedAt
        self.idempotencyRequestId = idempotencyRequestId
        self.addAction = addAction
    }
}

