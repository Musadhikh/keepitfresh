//
//  MergePolicy.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines merge-key rules for deciding merge-vs-create inventory item behavior.
//

import Foundation

public struct InventoryMergeKey: Sendable, Codable, Equatable, Hashable {
    public var householdId: String
    public var productId: String
    public var expiryDate: Date?
    public var openedAt: Date?
    public var storageLocationId: String
    public var lotOrBatchCode: String?

    public init(
        householdId: String,
        productId: String,
        expiryDate: Date?,
        openedAt: Date?,
        storageLocationId: String,
        lotOrBatchCode: String?
    ) {
        self.householdId = householdId
        self.productId = productId
        self.expiryDate = expiryDate
        self.openedAt = openedAt
        self.storageLocationId = storageLocationId
        self.lotOrBatchCode = lotOrBatchCode
    }
}

public enum InventoryAddAction: String, Sendable, Codable, Equatable, Hashable {
    case merged
    case created
}

