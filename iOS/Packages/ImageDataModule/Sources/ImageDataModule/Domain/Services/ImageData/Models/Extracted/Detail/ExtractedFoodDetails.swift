//
//  ExtractedFoodDetails.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import Foundation
import FoundationModels

@Generable(description: "Food specific information from the product")
public struct ExtractedFoodDetails: Sendable {
    @Guide(description: "Ingredient list values as shown on the product")
    public let ingredients: [String]?

    @Guide(description: "Allergen declarations or warnings")
    public var allergens: [String]?
    
    @Guide(description: "Serving size text")
    public var servingSize: String?
    
    @Guide(description: "Nutrition values per 100g or 100ml when available.")
    public var nutritionPer100gOrMl: ExtractedNutritionFactsExtraction?
    
    @Guide(description: "Quantity of the  product")
    public let quantity: String?

    @Guide(description: "Number of items in the product")
    public let numberOfItems: String?
    
    @Guide(description: "Confidence from 0.0 to 1.0 for food details.")
    public var confidence: Double?
}

extension ExtractedFoodDetails.PartiallyGenerated: Sendable {}
