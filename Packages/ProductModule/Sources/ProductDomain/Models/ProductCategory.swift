//
//  ProductCategory.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines stable product categorization used for filtering and details routing.
//

import Foundation

public struct ProductCategory: Sendable, Codable, Equatable {
    public var main: MainCategory
    public var sub: String?

    public init(main: MainCategory, sub: String? = nil) {
        self.main = main
        self.sub = sub
    }
}

public enum MainCategory: String, Sendable, Codable, CaseIterable {
    case food
    case beverage
    case household
    case personalCare
    case medicine
    case electronics
    case pet
    case other
}
