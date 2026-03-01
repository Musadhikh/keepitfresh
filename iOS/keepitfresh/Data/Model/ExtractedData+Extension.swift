//
//
//  ExtractedData+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ExtractedData+Extension
//
    

import Foundation
import ImageDataModule

extension MainCategory {
    init(generated: ExtractedMainCategory?) {
        switch generated {
            case .food: self = .food
            case .beverage: self = .beverage
            case .household: self = .household
            case .personalCare: self = .personalCare
            case .medicine: self = .medicine
            case .electronics: self = .electronics
            case .pet: self = .pet
            case .other, nil: self = .other
        }
    }
}

extension ExtractedData.PartiallyGenerated {
    func toProduct() -> Product {
        var pBarcode: Barcode?
        if let barcode = self.barcodeInfo?.barcode {
            let symbology: Barcode.Symbology = Barcode.Symbology(value: barcodeInfo?.barcodeType)
            pBarcode = Barcode(value: barcode, symbology: symbology)
        }
        
        let mainCategory = MainCategory(generated: self.category?.mainCategory)
        let pCategory = ProductCategory(main: mainCategory, subCategory: self.category?.subCategory)
        
        return Product(
            id: UUID().uuidString,
            title: self.title,
            shortDescription: self.shortDescription,
            barcode: pBarcode,
            images: [],
            category: pCategory,
            productDetail: getProductDetail(),
            source: .scan
        )
    }
    
    private func getProductDetail() -> ProductDetail {
        return switch productDetails {
            case .food(let extractedDetails):
                .food(extractedDetails?.toDetails())
            case .beverage(let extractedDetails):
                .food(extractedDetails?.toDetails())
            case .household(let extractedDetails):
                .household(extractedDetails?.toDetails())
            case .personalCare(let extractedDetails):
                .personalCare(extractedDetails?.toDetails())
            case .other(let extractedDetails):
                .other(extractedDetails?.toDetails())
            case nil: .other(nil)
        }
    }
}

extension ExtractedFoodDetails.PartiallyGenerated {
    func toDetails() -> FoodDetail {
        FoodDetail(
            ingredients: self.ingredients ?? [],
            allergens: self.allergens ?? [],
            nutritionPer100gOrMl: NutritionFacts(),
            servingSize: servingSize,
            countryOfOrigin: nil
        )
    }
}

extension ExtractedHouseholdDetails.PartiallyGenerated {
    func toDetails() -> HouseholdDetail {
        HouseholdDetail(
            usageInstructions: self.usageInstructions ?? [],
            safetyWarnings: self.safetyWarnings ?? [],
            materials: self.materials ?? []
        )
    }
}

extension ExtractedPersonalCareDetails.PartiallyGenerated {
    func toDetails() -> PersonalCareDetail {
        PersonalCareDetail(
            usageDirections: self.usageDirections,
            ingredients: self.ingredients,
            warnings: self.warnings,
            skinType: self.skinType
        )
    }
}

extension ExtractedUnknownDetails.PartiallyGenerated {
    func toDetails() -> UnknownDetails {
        var rawValues: [String: String] = [:]
        for value in self.raw ?? [] {
            if let key = value.key {
                rawValues[key] = value.value
            }
        }
        
        return UnknownDetails(raw: rawValues, category: self.category)
    }
}
