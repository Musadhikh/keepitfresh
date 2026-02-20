//
//  ProductClassificationExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Tiny pass-1 extraction model for category classification.
//

import Foundation
import FoundationModels

@Generable(description: "High-level product category classification output.")
enum MainCategoryExtraction: String, CaseIterable, Sendable {
    case food
    case beverage
    case household
    case personalCare = "personal_care"
    case medicine
    case electronics
    case pet
    case other
    case unknown
}

/// Pass-1 model used for fast category classification only.
@Generable
struct ProductClassificationExtraction: Sendable {
    @Guide(description: "Best-fit main category for this product.")
    var category: MainCategoryExtraction?

    @Guide(description: "Optional sub-category such as tea, shampoo, detergent, etc.")
    var subCategory: String?

    @Guide(description: "Classification confidence from 0.0 to 1.0.")
    var confidence: Double?

    @Guide(description: "Short reasoning for chosen category.")
    var reasoning: String?
}
