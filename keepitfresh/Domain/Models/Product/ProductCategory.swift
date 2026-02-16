//
//
//  ProductCategory.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ProductCategory
//
    
import FoundationModels

// MARK: - Category
@Generable
enum ProductCategory: String, CaseIterable, Sendable, ModelStringConvertible {
    case food
    case beverage
    case alcohol
    case medicine
    case supplement
    case personalCare
    case household
    case electronic
    case unknown
}
