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
    
    var notes: String?

    var lockedFields: Set<ProductField>
    var fieldConfidences: [ProductField: Double]
}
