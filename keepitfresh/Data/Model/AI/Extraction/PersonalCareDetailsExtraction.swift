//
//  PersonalCareDetailsExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Pass-3 personal-care-specific extraction model.
//

import Foundation
import FoundationModels

@Generable
struct PersonalCareDetailsExtraction: Sendable {
    @Guide(description: "Usage directions or instructions.")
    var usageDirections: [String]?

    @Guide(description: "Ingredients list if available.")
    var ingredients: [String]?

    @Guide(description: "Warnings and caution statements.")
    var warnings: [String]?

    @Guide(description: "Skin or hair type indicators.")
    var skinType: [String]?

    @Guide(description: "Raw text snippets used for personal care details.")
    var rawText: [String]?

    @Guide(description: "Confidence from 0.0 to 1.0 for personal care details.")
    var confidence: Double?
}
