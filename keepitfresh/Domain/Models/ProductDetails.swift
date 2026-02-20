//
//  ProductDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Category-specific details document stored under products/{id}/details/{category}.
//

import Foundation

/// Category-specific details attached to a product.
struct ProductDetails: Codable, Equatable, Sendable {
    var productId: String
    var category: MainCategory
    var schemaVersion: Int
    var packaging: ProductPackaging?
    var dateInfo: [ProductDateInfo]?
    var payload: ProductDetailsPayload
    var createdAt: Date?
    var updatedAt: Date?

    init(
        productId: String,
        category: MainCategory,
        schemaVersion: Int = 1,
        packaging: ProductPackaging? = nil,
        dateInfo: [ProductDateInfo]? = nil,
        payload: ProductDetailsPayload,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.productId = productId
        self.category = category
        self.schemaVersion = schemaVersion
        self.packaging = packaging
        self.dateInfo = dateInfo
        self.payload = payload
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
