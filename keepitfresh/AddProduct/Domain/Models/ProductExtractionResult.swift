//
//  ProductExtractionResult.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: AI/Vision extraction output used to build editable product drafts.
//

import Foundation

struct ProductExtractionResult: Codable, Sendable, Equatable, Hashable {
    var barcodeCandidates: [Barcode]
    var title: FieldConfidence<String>
    var brand: FieldConfidence<String>
    var size: FieldConfidence<String>
    var categories: FieldConfidence<[String]>
    var description: FieldConfidence<String>
    var images: [URL]?
    var dateInfo: [DateInfo]?

    init(
        barcodeCandidates: [Barcode] = [],
        title: FieldConfidence<String> = .init(),
        brand: FieldConfidence<String> = .init(),
        size: FieldConfidence<String> = .init(),
        categories: FieldConfidence<[String]> = .init(),
        description: FieldConfidence<String> = .init(),
        images: [URL]? = nil,
        dateInfo: [DateInfo]? = nil
    ) {
        self.barcodeCandidates = barcodeCandidates
        self.title = title
        self.brand = brand
        self.size = size
        self.categories = categories
        self.description = description
        self.images = images
        self.dateInfo = dateInfo
    }
}
