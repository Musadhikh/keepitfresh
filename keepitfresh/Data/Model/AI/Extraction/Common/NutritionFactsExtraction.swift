//
//  NutritionFactsExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Flexible nutrition extraction model for LLM output.
//

import Foundation
import FoundationModels

@Generable
struct NutritionFactsExtraction: Sendable {
    @Guide(description: "Energy in kcal per 100g or 100ml.")
    var energyKcal: Double?

    @Guide(description: "Protein in grams per 100g or 100ml.")
    var proteinG: Double?

    @Guide(description: "Fat in grams per 100g or 100ml.")
    var fatG: Double?

    @Guide(description: "Saturated fat in grams per 100g or 100ml.")
    var saturatedFatG: Double?

    @Guide(description: "Carbohydrates in grams per 100g or 100ml.")
    var carbsG: Double?

    @Guide(description: "Sugars in grams per 100g or 100ml.")
    var sugarsG: Double?

    @Guide(description: "Sodium in milligrams per 100g or 100ml.")
    var sodiumMg: Double?

    @Guide(description: "Raw nutrition block text used for extraction.")
    var rawText: [String]?

    @Guide(description: "Confidence from 0.0 to 1.0 for nutrition extraction.")
    var confidence: Double?
}
