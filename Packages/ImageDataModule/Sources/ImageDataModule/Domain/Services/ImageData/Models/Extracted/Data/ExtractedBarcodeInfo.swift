//
//  ExtractedBarcodeInfo.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed K on 23/2/26.
//

import FoundationModels

@Generable
public struct ExtractedBarcodeInfo: Sendable {
    @Guide(description: "Barcode value")
    public let barcode: String?

    @Guide(description: "Type of barcode")
    public let barcodeType: String?
}

extension ExtractedBarcodeInfo.PartiallyGenerated: Sendable {}
