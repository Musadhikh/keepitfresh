//
//  BarcodeExtraction.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Flexible LLM barcode extraction model with confidence and raw text.
//

import Foundation
import FoundationModels

@Generable
enum BarcodeSymbologyExtraction: String, CaseIterable, Sendable {
    case ean13
    case ean8
    case upca
    case upce
    case qr
    case code128
    case unknown
}

@Generable
struct BarcodeExtraction: Sendable {
    @Guide(description: "Barcode value as printed or scanned.")
    var value: String?

    @Guide(description: "Barcode symbology such as ean13, upca, qr.")
    var symbology: BarcodeSymbologyExtraction?

    @Guide(description: "Original raw barcode text before cleanup.")
    var rawText: String?

    @Guide(description: "Confidence from 0.0 to 1.0 for barcode extraction.")
    var confidence: Double?
}
