//
//  InventoryItemRecord.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines a backend-agnostic inventory item persistence record.
//

import Foundation

public struct InventoryItemRecord: Sendable, Codable, Equatable, Hashable {
    public var id: String
    public var householdId: String
    public var productId: String
    public var status: String
    public var expiryDate: Date?
    public var openedAt: Date?
    public var storageLocationId: String
    public var lotOrBatchCode: String?
    public var quantityValue: Double
    public var quantityUnit: String
    public var createdAt: Date
    public var updatedAt: Date
    public var consumedAt: Date?

    public init(
        id: String,
        householdId: String,
        productId: String,
        status: String,
        expiryDate: Date?,
        openedAt: Date?,
        storageLocationId: String,
        lotOrBatchCode: String?,
        quantityValue: Double,
        quantityUnit: String,
        createdAt: Date,
        updatedAt: Date,
        consumedAt: Date?
    ) {
        self.id = id
        self.householdId = householdId
        self.productId = productId
        self.status = status
        self.expiryDate = expiryDate
        self.openedAt = openedAt
        self.storageLocationId = storageLocationId
        self.lotOrBatchCode = lotOrBatchCode
        self.quantityValue = quantityValue
        self.quantityUnit = quantityUnit
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.consumedAt = consumedAt
    }
}
