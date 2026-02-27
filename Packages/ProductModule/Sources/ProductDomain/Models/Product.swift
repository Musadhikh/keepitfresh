//
//  Product.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines the canonical product aggregate owned by ProductModule.
//

import Foundation

public struct Product: Sendable, Codable, Equatable, Identifiable {
    public let productId: String
    public var id: String { productId }

    public var barcode: Barcode?
    public var title: String?
    public var brand: String?
    public var shortDescription: String?
    public var storageInstructions: String?
    public var category: ProductCategory?
    public var productDetails: ProductDetails?
    public var packaging: ProductPackaging?
    public var size: String?
    public var images: [ProductImage]
    public var attributes: [String: String]
    public var extractionMetadata: ProductExtractionMetadata?
    public var qualitySignals: ProductQualitySignals?
    public var compliance: ProductCompliance?
    public var source: ProductSource
    public var status: ProductStatus
    public var createdAt: Date
    public var updatedAt: Date
    public var version: Int

    public init(
        productId: String,
        barcode: Barcode? = nil,
        title: String? = nil,
        brand: String? = nil,
        shortDescription: String? = nil,
        storageInstructions: String? = nil,
        category: ProductCategory? = nil,
        productDetails: ProductDetails? = nil,
        packaging: ProductPackaging? = nil,
        size: String? = nil,
        images: [ProductImage] = [],
        attributes: [String: String] = [:],
        extractionMetadata: ProductExtractionMetadata? = nil,
        qualitySignals: ProductQualitySignals? = nil,
        compliance: ProductCompliance? = nil,
        source: ProductSource = .manual,
        status: ProductStatus = .active,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        version: Int = 1
    ) {
        self.productId = productId
        self.barcode = barcode
        self.title = title
        self.brand = brand
        self.shortDescription = shortDescription
        self.storageInstructions = storageInstructions
        self.category = category
        self.productDetails = productDetails
        self.packaging = packaging
        self.size = size
        self.images = images
        self.attributes = attributes
        self.extractionMetadata = extractionMetadata
        self.qualitySignals = qualitySignals
        self.compliance = compliance
        self.source = source
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.version = version
    }
}
