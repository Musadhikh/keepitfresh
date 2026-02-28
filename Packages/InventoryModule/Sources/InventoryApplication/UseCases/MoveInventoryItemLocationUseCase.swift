//
//  MoveInventoryItemLocationUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contracts for moving a batch between storage locations.
//

import Foundation
import InventoryDomain

public struct MoveInventoryItemLocationInput: Sendable, Equatable {
    public var householdId: String
    public var itemId: String
    public var targetLocationId: String
    public var idempotencyRequestId: String?

    public init(householdId: String, itemId: String, targetLocationId: String, idempotencyRequestId: String? = nil) {
        self.householdId = householdId
        self.itemId = itemId
        self.targetLocationId = targetLocationId
        self.idempotencyRequestId = idempotencyRequestId
    }
}

public struct MoveInventoryItemLocationOutput: Sendable, Equatable {
    public var item: InventoryItem
    public var syncState: InventorySyncState

    public init(item: InventoryItem, syncState: InventorySyncState) {
        self.item = item
        self.syncState = syncState
    }
}

public protocol MoveInventoryItemLocationUseCase: Sendable {
    func execute(_ input: MoveInventoryItemLocationInput) async throws -> MoveInventoryItemLocationOutput
}
