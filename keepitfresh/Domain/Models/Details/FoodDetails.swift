//
//  FoodDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable food-specific detail fields.
//

import Foundation

struct FoodDetails: Codable, Equatable, Sendable {
    var ingredients: [String]?
    var allergens: [String]?
    var nutritionPer100gOrMl: NutritionFacts?
    var servingSize: String?
    var countryOfOrigin: String?
}
