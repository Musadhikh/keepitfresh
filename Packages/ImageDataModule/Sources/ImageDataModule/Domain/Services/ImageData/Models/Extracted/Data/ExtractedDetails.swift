//
//  ExtractedDetails.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import FoundationModels

@Generable(description: "Product category specific information")
public enum ExtractedDetails: Sendable {
    case food(ExtractedFoodDetails?)
    case beverage(ExtractedFoodDetails?)
    case household
    case personalCare
    case medicine
    case electronics
    case pet
    case other
}

extension ExtractedDetails.PartiallyGenerated: Sendable {}

@Generable(description: "Food specific information")
public struct ExtractedFoodDetails: Sendable {
    @Guide(description: "Ingredients used in the product")
    public let ingredients: [String]?

    @Guide(description: "Quantity of the  product")
    public let quantity: String?

    @Guide(description: "Number of items in the product")
    public let numberOfItems: String?
}

extension ExtractedFoodDetails.PartiallyGenerated: Sendable {}
