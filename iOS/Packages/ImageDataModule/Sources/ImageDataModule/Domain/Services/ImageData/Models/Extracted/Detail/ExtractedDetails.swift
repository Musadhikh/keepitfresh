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
    case household(ExtractedHouseholdDetails?)
    case personalCare(ExtractedPersonalCareDetails?)
//    case medicine
//    case electronics
//    case pet
    case other(ExtractedUnknownDetails?)
}

extension ExtractedDetails.PartiallyGenerated: Sendable {}


