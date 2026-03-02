//
//  AddProductFlowPresentationModels.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: Presentation-layer models for Add Product screen composition and UI form state.
//

import Foundation
import ProductModule

enum AddProductFlowScreen: Equatable {
    case addActionSheet
    case scanLabel
    case extractionReview
    case productSearch
    case manualAdd
    case confirmPurchase
}

struct AddProductExtractionReviewDraft: Equatable {
    var productName: String = ""
    var brand: String = ""
    var category: MainCategory = .food
    var subCategory: String = ""
    var expiryDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    var manufacturedDate: Date = Date()
    var includeManufacturedDate = false
    var barcode: String = ""

    var trimmedProductName: String? {
        let value = productName.trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }

    var trimmedBrand: String? {
        let value = brand.trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }

    var trimmedSubCategory: String? {
        let value = subCategory.trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }

    var normalizedBarcode: String? {
        let value = barcode.trimmingCharacters(in: .whitespacesAndNewlines)
        return value.isEmpty ? nil : value
    }
}

enum AddProductSearchFilter: String, CaseIterable, Identifiable {
    case all
    case fresh
    case frozen
    case pantry
    case household

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: return "All"
        case .fresh: return "Fresh"
        case .frozen: return "Frozen"
        case .pantry: return "Pantry"
        case .household: return "Household"
        }
    }

    var mappedCategory: ProductModuleTypes.MainCategory? {
        switch self {
        case .all: return nil
        case .fresh, .frozen, .pantry: return .food
        case .household: return .household
        }
    }
}
