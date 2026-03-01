//
//  ExtractedPersonalCareDetailsExtraction.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import Foundation
import FoundationModels

@Generable(description: "Personal care specific information from the product")
public struct ExtractedPersonalCareDetails: Sendable {
    @Guide(description: "Usage directions or instructions.")
    public var usageDirections: [String]?
    
    @Guide(description: "Ingredients list if available.")
    public var ingredients: [String]?
    
    @Guide(description: "Warnings and caution statements.")
    public var warnings: [String]?
    
    @Guide(description: "Skin or hair type indicators.")
    public var skinType: [String]?
    
    @Guide(description: "Raw text snippets used for personal care details.")
    public var rawText: [String]?
    
    @Guide(description: "Confidence from 0.0 to 1.0 for personal care details.")
    public var confidence: Double?
}

extension ExtractedPersonalCareDetails.PartiallyGenerated: Sendable {}
