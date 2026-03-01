//
//  AddInventoryItemUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares merge-or-create inventory add use-case input/output contracts.
//

import Foundation
import InventoryDomain

public struct AddInventoryItemInput: Sendable, Equatable {
    public var householdId: String
    public var productRef: ProductRef
    public var quantity: Quantity
    public var storageLocationId: String
    public var expiryInfo: InventoryDateInfo?
    public var openedInfo: InventoryDateInfo?
    public var lotOrBatchCode: String?
    public var idempotencyRequestId: String?

    public init(
        householdId: String,
        productRef: ProductRef,
        quantity: Quantity,
        storageLocationId: String,
        expiryInfo: InventoryDateInfo? = nil,
        openedInfo: InventoryDateInfo? = nil,
        lotOrBatchCode: String? = nil,
        idempotencyRequestId: String? = nil
    ) {
        self.householdId = householdId
        self.productRef = productRef
        self.quantity = quantity
        self.storageLocationId = storageLocationId
        self.expiryInfo = expiryInfo
        self.openedInfo = openedInfo
        self.lotOrBatchCode = lotOrBatchCode
        self.idempotencyRequestId = idempotencyRequestId
    }
}

public struct AddInventoryItemOutput: Sendable, Equatable {
    public var itemId: String
    public var action: InventoryAddAction
    public var item: InventoryItem
    public var syncState: InventorySyncState

    public init(itemId: String, action: InventoryAddAction, item: InventoryItem, syncState: InventorySyncState) {
        self.itemId = itemId
        self.action = action
        self.item = item
        self.syncState = syncState
    }
}

public protocol AddInventoryItemUseCase: Sendable {
    func execute(_ input: AddInventoryItemInput) async throws -> AddInventoryItemOutput
}
