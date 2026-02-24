//
//  ProductPackaging.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable packaging and quantity metadata.
//

import Foundation

struct ProductPackaging: Codable, Equatable, Sendable {
    var quantity: Double?
    var unit: Unit
    var count: Int?
    var displayText: String?

    init(
        quantity: Double? = nil,
        unit: Unit = .unknown,
        count: Int? = nil,
        displayText: String? = nil
    ) {
        self.quantity = quantity
        self.unit = unit
        self.count = count
        self.displayText = displayText
    }
}

extension ProductPackaging {
    enum Unit: String, Codable, CaseIterable, Sendable {
        case g
        case kg
        case ml
        case l
        case oz
        case lb
        case count
        case unknown
    }
}
