//
//
//  Barcode.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: Barcode
//
    
import FoundationModels

// MARK: - Universal Supporting Types
@Generable
struct Barcode: Sendable {
    @Guide(description: "Primary barcode value (EAN/UPC/etc). Prefer digits only when possible.")
    var barcode: String?
    
    @Guide(description: "Barcode symbology if known (ean13, upca, qr, etc).")
    var barcodeType: BarcodeType?
}
@Generable
enum BarcodeType: String, CaseIterable, Sendable, ModelStringConvertible {
    case ean13, ean8, upca, upce, code128, code39, qr, datamatrix, pdf417, itf, unknown
}
