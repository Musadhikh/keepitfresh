//
//  ProductDraft.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Unified editable review model with source-based field locking.
//

import Foundation

struct ProductDraft: Codable, Sendable, Identifiable, Equatable {
    let id: String
    var source: ProductDataSource
    var isEditable: Bool

    var barcode: Barcode?
    var catalog: ProductCatalogItem?

    var title: String?
    var brand: String?
    var description: String?
    var categories: [String]?
    var category: ProductCategory?
    var productDetail: ProductDetail?
    var size: String?
    var images: [Data]

    var quantity: Int
    var numberOfItems: Int
    var unit: String?
    var dateEntries: [ProductDraftDateEntry]
    
    var notes: String?

    var lockedFields: Set<ProductField>
    var fieldConfidences: [ProductField: Double]
}

struct ProductDraftDateEntry: Codable, Sendable, Equatable, Hashable {
    var kind: ProductDateInfo.Kind
    var value: Date?
    var inputMode: ProductDraftDateInputMode

    init(kind: ProductDateInfo.Kind, value: Date? = nil, inputMode: ProductDraftDateInputMode = .manualCalendar) {
        self.kind = kind
        self.value = value
        self.inputMode = inputMode
    }
}

enum ProductDraftDateInputMode: String, Codable, Sendable, Equatable, Hashable {
    case manualCalendar
    case scanImage
}
