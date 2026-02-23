//
//  ExtractedBarcodeInfo.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import FoundationModels

@Generable
public struct ExtractedBarcodeInfo: Sendable {
    @Guide(description: "arcode value as printed or scanned")
    public let barcode: String?

    @Guide(description: "Barcode symbology such as ean13, upca, qr")
    public let barcodeType: String?
    
    @Guide(description: "Confidence from 0.0 to 1.0 for barcode extraction.")
    public var confidence: Double?
}

extension ExtractedBarcodeInfo.PartiallyGenerated: Sendable {}
