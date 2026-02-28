//
//  UpdateInventoryItemDatesUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contracts for updating batch date metadata.
//

import Foundation
import InventoryDomain

public struct UpdateInventoryItemDatesInput: Sendable, Equatable {
    public var householdId: String
    public var itemId: String
    public var expiryInfo: InventoryDateInfo?
    public var openedInfo: InventoryDateInfo?
    public var idempotencyRequestId: String?

    public init(
        householdId: String,
        itemId: String,
        expiryInfo: InventoryDateInfo?,
        openedInfo: InventoryDateInfo?,
        idempotencyRequestId: String? = nil
    ) {
        self.householdId = householdId
        self.itemId = itemId
        self.expiryInfo = expiryInfo
        self.openedInfo = openedInfo
        self.idempotencyRequestId = idempotencyRequestId
    }
}

public struct UpdateInventoryItemDatesOutput: Sendable, Equatable {
    public var item: InventoryItem
    public var syncState: InventorySyncState

    public init(item: InventoryItem, syncState: InventorySyncState) {
        self.item = item
        self.syncState = syncState
    }
}

public protocol UpdateInventoryItemDatesUseCase: Sendable {
    func execute(_ input: UpdateInventoryItemDatesInput) async throws -> UpdateInventoryItemDatesOutput
}
