//
//  ExtractedProductCategory.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import FoundationModels

@Generable(description: "Product type and subtype")
public struct ExtractedProductCategory: Sendable {
    @Guide(description: "Broad type of the product")
    public let mainCategory: ExtractedMainCategory?

    @Guide(description: "Granular type of category")
    public let subCategory: String?
}

extension ExtractedProductCategory.PartiallyGenerated: Sendable {}

@Generable
public enum ExtractedMainCategory: String, Codable, CaseIterable, Sendable {
    case food
    case beverage
    case household
    case personalCare
    case medicine
    case electronics
    case pet
    case other
}
