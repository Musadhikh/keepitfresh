//
//  ProductCategory.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable domain category model for persistence and UI.
//

import Foundation

/// Stable top-level categories used for Firestore storage and app routing.
enum MainCategory: String, Codable, CaseIterable, Sendable {
    case food
    case beverage
    case household
    case personalCare
    case medicine
    case electronics
    case pet
    case other
}

/// Product category pair with an optional subtype.
struct ProductCategory: Codable, Equatable, Sendable {
    var main: MainCategory
    var subCategory: String?
}

private extension ProductCategory {
    static func sanitized(_ value: String?) -> String? {
        guard let value else { return nil }
        let normalized = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return normalized.isEmpty ? nil : normalized
    }
}
