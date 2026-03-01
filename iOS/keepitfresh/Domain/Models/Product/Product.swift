//
//  Product.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable base product document stored under products/{productId}.
//

import Foundation

/// Stable product base model for Firestore and UI usage.
struct Product: Codable, Equatable, Sendable {
    var id: String
    var title: String?
    var brand: String?
    var shortDescription: String?
    var barcode: Barcode?
    var images: [ProductImage]
    var category: ProductCategory
    var productDetail: ProductDetail
    var source: ProductSource
}
