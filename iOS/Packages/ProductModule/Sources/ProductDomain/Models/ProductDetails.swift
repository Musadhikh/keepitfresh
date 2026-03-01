//
//  ProductDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines category-specific product detail payloads without inventory-only fields.
//

import Foundation

public enum ProductDetails: Sendable, Codable, Equatable {
    case food(FoodDetails?)
    case beverage(FoodDetails?)
    case household(HouseholdDetails?)
    case personalCare(PersonalCareDetails?)
    case other(UnknownDetails?)
}

public struct FoodDetails: Sendable, Codable, Equatable {
    public var ingredients: [String]?
    public var allergens: [String]?
    public var servingSize: String?
    public var nutritionPer100gOrMl: NutritionFacts?
    public var quantityText: String?
    public var numberOfItemsText: String?

    public init(
        ingredients: [String]? = nil,
        allergens: [String]? = nil,
        servingSize: String? = nil,
        nutritionPer100gOrMl: NutritionFacts? = nil,
        quantityText: String? = nil,
        numberOfItemsText: String? = nil
    ) {
        self.ingredients = ingredients
        self.allergens = allergens
        self.servingSize = servingSize
        self.nutritionPer100gOrMl = nutritionPer100gOrMl
        self.quantityText = quantityText
        self.numberOfItemsText = numberOfItemsText
    }
}

public struct HouseholdDetails: Sendable, Codable, Equatable {
    public var usageInstructions: [String]?
    public var safetyWarnings: [String]?
    public var materials: [String]?

    public init(
        usageInstructions: [String]? = nil,
        safetyWarnings: [String]? = nil,
        materials: [String]? = nil
    ) {
        self.usageInstructions = usageInstructions
        self.safetyWarnings = safetyWarnings
        self.materials = materials
    }
}

public struct PersonalCareDetails: Sendable, Codable, Equatable {
    public var usageDirections: [String]?
    public var ingredients: [String]?
    public var warnings: [String]?
    public var skinType: [String]?

    public init(
        usageDirections: [String]? = nil,
        ingredients: [String]? = nil,
        warnings: [String]? = nil,
        skinType: [String]? = nil
    ) {
        self.usageDirections = usageDirections
        self.ingredients = ingredients
        self.warnings = warnings
        self.skinType = skinType
    }
}

public struct UnknownDetails: Sendable, Codable, Equatable {
    public var keyValue: [String: String]
    public var inferredCategory: String?

    public init(keyValue: [String: String] = [:], inferredCategory: String? = nil) {
        self.keyValue = keyValue
        self.inferredCategory = inferredCategory
    }
}

public struct NutritionFacts: Sendable, Codable, Equatable {
    public var energyKcal: Double?
    public var proteinG: Double?
    public var fatG: Double?
    public var saturatedFatG: Double?
    public var carbsG: Double?
    public var sugarsG: Double?
    public var sodiumMg: Double?

    public init(
        energyKcal: Double? = nil,
        proteinG: Double? = nil,
        fatG: Double? = nil,
        saturatedFatG: Double? = nil,
        carbsG: Double? = nil,
        sugarsG: Double? = nil,
        sodiumMg: Double? = nil
    ) {
        self.energyKcal = energyKcal
        self.proteinG = proteinG
        self.fatG = fatG
        self.saturatedFatG = saturatedFatG
        self.carbsG = carbsG
        self.sugarsG = sugarsG
        self.sodiumMg = sodiumMg
    }
}
