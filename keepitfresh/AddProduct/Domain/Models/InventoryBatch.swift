//
//  InventoryBatch.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Inventory quantity/date batch record for an item.
//

import Foundation

struct InventoryBatch: Codable, Sendable, Identifiable, Equatable, Hashable {
    let id: String
    var quantity: Int
    var unit: String?
    var dates: [DateInfo]
    var notes: String?

    init(
        id: String = UUID().uuidString,
        quantity: Int,
        unit: String? = nil,
        dates: [DateInfo] = [],
        notes: String? = nil
    ) {
        self.id = id
        self.quantity = quantity
        self.unit = unit
        self.dates = dates
        self.notes = notes
    }
}
