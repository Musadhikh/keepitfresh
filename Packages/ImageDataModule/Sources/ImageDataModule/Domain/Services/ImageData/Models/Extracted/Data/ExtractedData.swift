//
//  ExtractedData.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Structured model generated from extracted text and barcode signals.
//

import Foundation
import FoundationModels

@Generable
public struct ExtractedData: Sendable {
    @Guide(description: "Product title or name")
    public let title: String?

    @Guide(description: "Brand of the product")
    public let brand: String?

    @Guide(description: "Describe the product briefly")
    public let shortDescription: String?

    @Guide(description: "Primary Barcode/UPC details")
    public let barcodeInfo: ExtractedBarcodeInfo?

    @Guide(description: "All date information printed on the product. Keep same date format for all dates in the list. Preferred date format is dd/MM/yyyy")
    public let dateInfo: [ExtractedDateInfo]?

    @Guide(description: "Product category")
    public let category: ExtractedProductCategory?

    @Guide(description: "Storage instructions of the product")
    public let storageInstructions: String?

    @Guide(description: "Product details based on the category")
    public let productDetails: ExtractedDetails?
}

extension ExtractedData.PartiallyGenerated: Sendable {}
