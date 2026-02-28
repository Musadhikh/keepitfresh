//
//  InventoryItem.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines the batch-level inventory aggregate used for household stock tracking.
//

import Foundation

public struct InventoryItem: Sendable, Codable, Equatable, Hashable {
    public var id: String
    public var householdId: String
    public var productRef: ProductRef
    public var quantity: Quantity
    public var status: InventoryItemStatus
    public var storageLocationId: String
    public var lotOrBatchCode: String?
    public var expiryInfo: InventoryDateInfo?
    public var openedInfo: InventoryDateInfo?
    public var notes: String?
    public var createdAt: Date
    public var updatedAt: Date
    public var consumedAt: Date?

    public init(
        id: String,
        householdId: String,
        productRef: ProductRef,
        quantity: Quantity,
        status: InventoryItemStatus,
        storageLocationId: String,
        lotOrBatchCode: String? = nil,
        expiryInfo: InventoryDateInfo? = nil,
        openedInfo: InventoryDateInfo? = nil,
        notes: String? = nil,
        createdAt: Date,
        updatedAt: Date,
        consumedAt: Date? = nil
    ) {
        self.id = id
        self.householdId = householdId
        self.productRef = productRef
        self.quantity = quantity
        self.status = status
        self.storageLocationId = storageLocationId
        self.lotOrBatchCode = lotOrBatchCode
        self.expiryInfo = expiryInfo
        self.openedInfo = openedInfo
        self.notes = notes
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.consumedAt = consumedAt
    }
}

