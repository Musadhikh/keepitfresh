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
    var barcode: Barcode?
    var brand: String?
    var shortDescription: String?
    var images: [ProductImage]
    var categories: [ProductCategory]
    var createdAt: Date?
    var updatedAt: Date?
    var lastScannedAt: Date?
    var source: ProductSource
    var confidence: Double?
    var rawTextRefs: [String]

    /// Primary category derived from the first category entry.
    var primaryCategory: ProductCategory? {
        categories.first
    }

    init(
        id: String,
        title: String? = nil,
        barcode: Barcode? = nil,
        brand: String? = nil,
        shortDescription: String? = nil,
        images: [ProductImage] = [],
        categories: [ProductCategory] = [],
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        lastScannedAt: Date? = nil,
        source: ProductSource = .unknown,
        confidence: Double? = nil,
        rawTextRefs: [String] = []
    ) {
        self.id = id
        self.title = title
        self.barcode = barcode
        self.brand = brand
        self.shortDescription = shortDescription
        self.images = images
        self.categories = categories
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.lastScannedAt = lastScannedAt
        self.source = source
        self.confidence = confidence
        self.rawTextRefs = rawTextRefs
    }
}
