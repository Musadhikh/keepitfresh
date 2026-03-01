//
//  ProductSupportingTypes.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines reusable supporting product models for packaging, images, quality, and compliance.
//

import Foundation

public struct ProductPackaging: Sendable, Codable, Equatable {
    public var quantity: Double?
    public var unit: Unit
    public var count: Int?
    public var displayText: String?

    public init(
        quantity: Double? = nil,
        unit: Unit = .unknown,
        count: Int? = nil,
        displayText: String? = nil
    ) {
        self.quantity = quantity
        self.unit = unit
        self.count = count
        self.displayText = displayText
    }
}

public extension ProductPackaging {
    enum Unit: String, Sendable, Codable, CaseIterable {
        case g
        case kg
        case ml
        case l
        case oz
        case lb
        case count
        case unknown
    }
}

public struct ProductImage: Sendable, Codable, Equatable {
    public var id: String
    public var urlString: String?
    public var localAssetId: String?
    public var kind: Kind
    public var width: Int?
    public var height: Int?

    public init(
        id: String = UUID().uuidString,
        urlString: String? = nil,
        localAssetId: String? = nil,
        kind: Kind = .other,
        width: Int? = nil,
        height: Int? = nil
    ) {
        self.id = id
        self.urlString = urlString
        self.localAssetId = localAssetId
        self.kind = kind
        self.width = width
        self.height = height
    }
}

public extension ProductImage {
    enum Kind: String, Sendable, Codable, CaseIterable {
        case front
        case back
        case label
        case nutrition
        case ingredients
        case other
    }
}

public struct ProductExtractionMetadata: Sendable, Codable, Equatable {
    public var extractedAt: Date?
    public var extractorVersion: String?
    public var fieldConfidence: [String: Double]
    public var rawSnippets: [String]

    public init(
        extractedAt: Date? = nil,
        extractorVersion: String? = nil,
        fieldConfidence: [String: Double] = [:],
        rawSnippets: [String] = []
    ) {
        self.extractedAt = extractedAt
        self.extractorVersion = extractorVersion
        self.fieldConfidence = fieldConfidence
        self.rawSnippets = rawSnippets
    }
}

public struct ProductQualitySignals: Sendable, Codable, Equatable {
    public var completenessScore: Double?
    public var needsManualReview: Bool
    public var hasFrontImage: Bool
    public var hasIngredientImage: Bool
    public var hasNutritionImage: Bool

    public init(
        completenessScore: Double? = nil,
        needsManualReview: Bool = false,
        hasFrontImage: Bool = false,
        hasIngredientImage: Bool = false,
        hasNutritionImage: Bool = false
    ) {
        self.completenessScore = completenessScore
        self.needsManualReview = needsManualReview
        self.hasFrontImage = hasFrontImage
        self.hasIngredientImage = hasIngredientImage
        self.hasNutritionImage = hasNutritionImage
    }
}

public struct ProductCompliance: Sendable, Codable, Equatable {
    public var marketCountries: [String]
    public var restrictedFlags: [String]
    public var certifications: [String]

    public init(
        marketCountries: [String] = [],
        restrictedFlags: [String] = [],
        certifications: [String] = []
    ) {
        self.marketCountries = marketCountries
        self.restrictedFlags = restrictedFlags
        self.certifications = certifications
    }
}

public enum ProductSource: String, Sendable, Codable, CaseIterable {
    case manual
    case barcodeLookup
    case aiExtraction
    case importedFeed
    case merged
}

public enum ProductStatus: String, Sendable, Codable, CaseIterable {
    case active
    case draft
    case archived
    case blocked
}
