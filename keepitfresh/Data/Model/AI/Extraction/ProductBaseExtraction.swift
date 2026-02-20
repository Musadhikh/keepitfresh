//
//  ProductBaseExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Pass-2 base extraction model for stable product fields.
//

import Foundation
import FoundationModels

/// Pass-2 base model that extracts product fields shared by all categories.
@Generable
struct ProductBaseExtraction: Sendable {
    @Guide(description: "Product title as printed on label.")
    var title: String?

    @Guide(description: "Primary brand or manufacturer if visible.")
    var brand: String?

    @Guide(description: "Primary barcode data extracted from text or scanner hints.")
    var barcode: BarcodeExtraction?

    @Guide(description: "Short one-line product description.")
    var shortDescription: String?

    @Guide(description: "Any image URLs explicitly visible in the source text.")
    var images: [String]?

    @Guide(description: "Main category inferred from available context.")
    var category: MainCategoryExtraction?

    @Guide(description: "Optional subtype such as tea, cereal, shampoo.")
    var subCategory: String?

    @Guide(description: "Overall confidence for base extraction.")
    var confidence: Double?

    @Guide(description: "Raw OCR lines used for this extraction.")
    var rawText: [String]?
}
