//
//  ProductPackagingExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Flexible packaging extraction model.
//

import Foundation
import FoundationModels

@Generable
enum ProductPackagingUnitExtraction: String, CaseIterable, Sendable {
    case g
    case kg
    case ml
    case l
    case oz
    case lb
    case count
    case unknown
}

@Generable
struct ProductPackagingExtraction: Sendable {
    @Guide(description: "Numeric quantity value for package size.")
    var quantity: Double?

    @Guide(description: "Quantity unit such as g, kg, ml, l, count.")
    var unit: ProductPackagingUnitExtraction?

    @Guide(description: "Count of items inside package if applicable.")
    var count: Int?

    @Guide(description: "Packaging display text exactly as printed.")
    var displayText: String?

    @Guide(description: "Raw packaging text before normalization.")
    var rawText: String?

    @Guide(description: "Confidence from 0.0 to 1.0 for packaging extraction.")
    var confidence: Double?
}
