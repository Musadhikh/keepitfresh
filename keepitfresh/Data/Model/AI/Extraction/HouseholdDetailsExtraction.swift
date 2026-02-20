//
//  HouseholdDetailsExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Pass-3 household-specific extraction model.
//

import Foundation
import FoundationModels

@Generable
struct HouseholdDetailsExtraction: Sendable {
    @Guide(description: "Usage instructions extracted from label text.")
    var usageInstructions: [String]?

    @Guide(description: "Safety warnings or caution statements.")
    var safetyWarnings: [String]?

    @Guide(description: "Material composition details if present.")
    var materials: [String]?

    @Guide(description: "Raw text snippets used for household details.")
    var rawText: [String]?

    @Guide(description: "Confidence from 0.0 to 1.0 for household details.")
    var confidence: Double?
}
