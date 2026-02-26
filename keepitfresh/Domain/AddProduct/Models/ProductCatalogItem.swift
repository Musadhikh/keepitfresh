//
//  ProductCatalogItem.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Canonical catalog record used to prefill review drafts.
//

import Foundation

struct ProductCatalogItem: Codable, Sendable, Identifiable, Equatable, Hashable {
    let id: String
    let barcode: Barcode
    let title: String?
    let brand: String?
    let description: String?
    let images: [URL]?
    let categories: [String]?
    let size: String?

    init(
        id: String,
        barcode: Barcode,
        title: String? = nil,
        brand: String? = nil,
        description: String? = nil,
        images: [URL]? = nil,
        categories: [String]? = nil,
        size: String? = nil
    ) {
        self.id = id
        self.barcode = barcode
        self.title = title
        self.brand = brand
        self.description = description
        self.images = images
        self.categories = categories
        self.size = size
    }
}
