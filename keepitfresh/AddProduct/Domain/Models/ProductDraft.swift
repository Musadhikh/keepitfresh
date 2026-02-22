//
//  ProductDraft.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Unified editable review model with source-based field locking.
//

import Foundation

struct ProductDraft: Codable, Sendable, Identifiable, Equatable, Hashable {
    let id: String
    var source: ProductDataSource

    var barcode: Barcode?
    var catalog: ProductCatalogItem?

    var title: String?
    var brand: String?
    var description: String?
    var categories: [String]?
    var size: String?
    var images: [Data]

    var quantity: Int
    var unit: String?
    var dateInfo: [DateInfo]
    var notes: String?

    var lockedFields: Set<ProductField>
    var fieldConfidences: [ProductField: Double]

    init(
        id: String = UUID().uuidString,
        source: ProductDataSource,
        barcode: Barcode? = nil,
        catalog: ProductCatalogItem? = nil,
        title: String? = nil,
        brand: String? = nil,
        description: String? = nil,
        categories: [String]? = nil,
        size: String? = nil,
        images: [Data] = [],
        quantity: Int = 1,
        unit: String? = nil,
        dateInfo: [DateInfo] = [],
        notes: String? = nil,
        lockedFields: Set<ProductField> = [],
        fieldConfidences: [ProductField: Double] = [:]
    ) {
        self.id = id
        self.source = source
        self.barcode = barcode
        self.catalog = catalog
        self.title = title
        self.brand = brand
        self.description = description
        self.categories = categories
        self.size = size
        self.images = images
        self.quantity = max(1, quantity)
        self.unit = unit
        self.dateInfo = dateInfo
        self.notes = notes
        self.lockedFields = lockedFields
        self.fieldConfidences = fieldConfidences
    }
}

extension ProductDraft {
    static func makeManual() -> ProductDraft {
        ProductDraft(source: .manual)
    }
}
