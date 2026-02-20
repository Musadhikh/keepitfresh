//
//  FoodDetailsExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Pass-3 food-specific extraction model.
//

import Foundation
import FoundationModels

@Generable
struct FoodDetailsExtraction: Sendable {
    @Guide(description: "Ingredient list values as shown on the product.")
    var ingredients: [String]?

    @Guide(description: "Allergen declarations or warnings.")
    var allergens: [String]?

    @Guide(description: "Nutrition values per 100g or 100ml when available.")
    var nutritionPer100gOrMl: NutritionFactsExtraction?

    @Guide(description: "Serving size text.")
    var servingSize: String?

    @Guide(description: "Country of origin when visible.")
    var countryOfOrigin: String?

    @Guide(description: "Raw text snippets used for food details.")
    var rawText: [String]?

    @Guide(description: "Confidence from 0.0 to 1.0 for food details.")
    var confidence: Double?
}
