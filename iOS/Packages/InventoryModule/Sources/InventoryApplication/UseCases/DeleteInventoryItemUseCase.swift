//
//  DeleteInventoryItemUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contracts for archiving an inventory batch with offline-first sync-state tracking.
//

import Foundation
import InventoryDomain

public struct DeleteInventoryItemInput: Sendable, Equatable {
    public var householdId: String
    public var itemId: String
    public var idempotencyRequestId: String?

    public init(
        householdId: String,
        itemId: String,
        idempotencyRequestId: String? = nil
    ) {
        self.householdId = householdId
        self.itemId = itemId
        self.idempotencyRequestId = idempotencyRequestId
    }
}

public struct DeleteInventoryItemOutput: Sendable, Equatable {
    public var item: InventoryItem
    public var syncState: InventorySyncState

    public init(item: InventoryItem, syncState: InventorySyncState) {
        self.item = item
        self.syncState = syncState
    }
}

public protocol DeleteInventoryItemUseCase: Sendable {
    func execute(_ input: DeleteInventoryItemInput) async throws -> DeleteInventoryItemOutput
}
