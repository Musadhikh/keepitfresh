//
//
//  ExtractedData.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: ExtractedData
//
    

import Foundation
import FoundationModels

@Generable
struct ExtractedData: Sendable {
    @Guide(description: "Product title or name")
    let title: String?
    
    @Guide(description: "Brand of the product")
    let brand: String?
    
    @Guide(description: "Describe the product briefly")
    let description: String?
    
    @Guide(description: "Barcode/UPC details")
    let barcodeInfo: BarcodeInfo?
    
    
    @Guide(description: "All date information printed on the product. Keep same date format for all dates in the list. Preferred date format is dd/MM/yyyy")
    let dateInfo: [ExtractedDateInfo]?
    
    @Guide(description: "Product category")
    let category: ExtractedProductCategory?
    
    @Guide(description: "Storage instructions of the product")
    let storageInstructions: String?
    
    @Guide(description: "Product details based on the category")
    let productDetails: ExtractedDetails?
}

@Generable
struct BarcodeInfo {
    @Guide(description: "Barcode value")
    let barcode: String?
    
    @Guide(description: "Type of barcode")
    let barcodeType: String?
}

@Generable
struct ExtractedDateInfo {
    @Guide(description: "Type of Date (Packed, Expiry, etc.) printed on the product")
    let dateType: DateTypeEnum?
    @Guide(description: "Date printed on the product. Always convert to the format: dd/MM/yyyy")
    let date: String?
}

@Generable(description: "Date type to infer from the label on the product. pkd, packed, packed on means => packed. prod, mfd, manufactured, manufactured on means => manufactured. exp, expiry, expiry on means => expiry. use by, useBy, useBy on means => useBy. bb, best before, bestBefore, bestBefore on means => bestBefore. use before, useBefore, useBefore on means => useBefore.")
enum DateTypeEnum: String, CaseIterable {
    case packed
    case manufactured
    case expiry
    case useBy
    case bestBefore
    case useBefore
}


@Generable(description: "Product type and subtype")
struct ExtractedProductCategory {
    @Guide(description: "Broad type of the product")
    let mainCategory: ExtractedMainCategory?
    
    @Guide(description: "Granular type of category")
    let subCategory: String?
}

@Generable
enum ExtractedMainCategory: String, Codable, CaseIterable, Sendable {
    case food
    case beverage
    case household
    case personalCare = "personal_care"
    case medicine
    case electronics
    case pet
    case other
}

@Generable(description: "Product category specific information")
enum ExtractedDetails {
    case food(ExtractedFoodDetails?)
    case beverage(ExtractedFoodDetails?)
    case household
    case personalCare
    case medicine
    case electronics
    case pet
    case other
}

@Generable(description: "Food specific information")
struct ExtractedFoodDetails {
    @Guide(description: "Ingredients used in the product")
    let ingredients: [String]?
    
    @Guide(description: "Quantity of the  product")
    let quantity: String?
    
    @Guide(description: "Number of items in the product")
    let numberOfItems: String?
}
