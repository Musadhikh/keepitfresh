//
//  InventoryItem.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Household inventory aggregate with batch history.
//

import Foundation

struct InventoryItem: Codable, Sendable, Identifiable, Equatable, Hashable {
    let id: String
    let householdId: String
    var barcode: Barcode?
    var catalogRefId: String?
    var batches: [InventoryBatch]
    var updatedAt: Date?
    var needsBarcode: Bool

    init(
        id: String,
        householdId: String,
        barcode: Barcode?,
        catalogRefId: String? = nil,
        batches: [InventoryBatch] = [],
        updatedAt: Date? = nil,
        needsBarcode: Bool = false
    ) {
        self.id = id
        self.householdId = householdId
        self.barcode = barcode
        self.catalogRefId = catalogRefId
        self.batches = batches
        self.updatedAt = updatedAt
        self.needsBarcode = needsBarcode
    }
}
