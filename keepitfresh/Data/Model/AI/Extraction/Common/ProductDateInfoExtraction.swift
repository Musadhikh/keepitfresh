//
//  ProductDateInfoExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Flexible date extraction model with raw text and confidence.
//

import Foundation
import FoundationModels

@Generable
enum ProductDateKindExtraction: String, CaseIterable, Sendable {
    case expiry
    case bestBefore = "best_before"
    case useBy = "use_by"
    case manufactured
    case packedOn = "packed_on"
    case unknown
}

@Generable
struct ProductDateInfoExtraction: Sendable {
    @Guide(description: "Date kind such as expiry, best_before, use_by, manufactured, packed_on.")
    var kind: ProductDateKindExtraction?

    @Guide(description: "Date string exactly as seen in text.")
    var rawText: String?

    @Guide(description: "ISO date candidate like 2026-03-31 when confidence is high.")
    var isoDate: String?

    @Guide(description: "Confidence from 0.0 to 1.0 for date extraction.")
    var confidence: Double?
}
