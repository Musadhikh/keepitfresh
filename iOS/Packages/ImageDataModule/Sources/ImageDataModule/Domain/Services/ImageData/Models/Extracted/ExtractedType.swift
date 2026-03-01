//
//  ExtractedType.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Raw OCR/barcode extraction output produced by Vision processing.
//

import FoundationModels
import Vision

public enum ExtractedType: Sendable, ModelStringConvertible {
    case barcode(value: String, symbology: BarcodeSymbology)
    case paragraph(value: [String])
}

extension ExtractedType: PromptRepresentable {
    public var promptRepresentation: Prompt {
        switch self {
        case .barcode(let value, _):
            value.promptRepresentation
        case .paragraph(let value):
            value.promptRepresentation
        }
    }
}
