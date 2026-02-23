//
//  ExtractedHouseholdDetails.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import Foundation
import FoundationModels

@Generable(description: "Household specific information from the product")
public struct ExtractedHouseholdDetails: Sendable {
    @Guide(description: "Usage instructions extracted from label text.")
    public var usageInstructions: [String]?
    
    @Guide(description: "Safety warnings or caution statements.")
    public var safetyWarnings: [String]?
    
    @Guide(description: "Material composition details if present.")
    public var materials: [String]?
    
    @Guide(description: "Raw text snippets used for household details.")
    public var rawText: [String]?
    
    @Guide(description: "Confidence from 0.0 to 1.0 for household details.")
    public var confidence: Double?
}

extension ExtractedHouseholdDetails.PartiallyGenerated: Sendable {}
