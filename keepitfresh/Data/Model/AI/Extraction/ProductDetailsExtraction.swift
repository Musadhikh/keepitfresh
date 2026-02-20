//
//  ProductDetailsExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Pass-3 wrapper for common details plus category-specific detail branches.
//

import Foundation
import FoundationModels

/// Pass-3 wrapper with common detail fields and one category-specific branch.
@Generable
struct ProductDetailsExtraction: Sendable {
    @Guide(description: "Packaging quantity/unit/count values when present.")
    var packaging: ProductPackagingExtraction?

    @Guide(description: "Detected date labels such as expiry, best before, packed on.")
    var dateInfo: [ProductDateInfoExtraction]?

    @Guide(description: "Category-specific food details.")
    var food: FoodDetailsExtraction?

    @Guide(description: "Category-specific household details.")
    var household: HouseholdDetailsExtraction?

    @Guide(description: "Category-specific personal care details.")
    var personalCare: PersonalCareDetailsExtraction?

    @Guide(description: "Overall confidence for details extraction.")
    var confidence: Double?
}
