//
//  InventorySyncObservability.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Provides observability hooks for inventory sync execution and outcomes.
//

import Foundation
import InventoryDomain

public enum InventorySyncFailureCategory: String, Sendable, Equatable {
    case conflict
    case transient
    case validation
    case unknown
}

public enum InventorySyncEvent: Sendable, Equatable {
    case started(householdId: String)
    case skippedOffline(householdId: String)
    case itemSkipped(itemId: String, operation: InventorySyncOperation, reason: String)
    case itemSynced(itemId: String, operation: InventorySyncOperation)
    case itemFailed(itemId: String, operation: InventorySyncOperation, category: InventorySyncFailureCategory)
    case completed(householdId: String, attempted: Int, synced: Int, failed: Int, skipped: Int)
}

public protocol InventorySyncObservability: Sendable {
    func record(_ event: InventorySyncEvent) async
}

public struct NoOpInventorySyncObservability: InventorySyncObservability {
    public init() {}

    public func record(_ event: InventorySyncEvent) async {}
}
