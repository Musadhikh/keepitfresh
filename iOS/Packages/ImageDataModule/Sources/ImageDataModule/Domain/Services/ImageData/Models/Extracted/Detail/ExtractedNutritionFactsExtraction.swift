//
//  File.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import Foundation
import FoundationModels

@Generable
public struct ExtractedNutritionFactsExtraction: Sendable {
    @Guide(description: "Energy in kcal per 100g or 100ml.")
    public var energyKcal: Double?
    
    @Guide(description: "Protein in grams per 100g or 100ml.")
    public var proteinG: Double?
    
    @Guide(description: "Fat in grams per 100g or 100ml.")
    public var fatG: Double?
    
    @Guide(description: "Saturated fat in grams per 100g or 100ml.")
    public var saturatedFatG: Double?
    
    @Guide(description: "Carbohydrates in grams per 100g or 100ml.")
    public var carbsG: Double?
    
    @Guide(description: "Sugars in grams per 100g or 100ml.")
    public var sugarsG: Double?
    
    @Guide(description: "Sodium in milligrams per 100g or 100ml.")
    public var sodiumMg: Double?
    
    @Guide(description: "Raw nutrition block text used for extraction.")
    public var rawText: [String]?
    
    @Guide(description: "Confidence from 0.0 to 1.0 for nutrition extraction.")
    public var confidence: Double?
}

extension ExtractedNutritionFactsExtraction.PartiallyGenerated: Sendable {}
