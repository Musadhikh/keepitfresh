//
//
//  Product.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: Product
//
    

import Foundation
import FoundationModels

@Generable
struct Product: Sendable {
    @Guide(description: "Human-friendly product name/title as printed on the label.")
    var title: String?
    
    @Guide(description: "Primary barcode value (EAN/UPC/QR) and the type of barcode (ean13, upca, qr etc.")
    var barcode: Barcode?
    
    @Guide(description: "Brand / manufacturer as printed.")
    var brand: String?
    
    @Guide(description: "High-level classification of the product based on label context. If unclear, use unknown.")
    var category: ProductCategory?
    
    @Guide(description: """
    List of any date-like information on the label: expiry, best before, manufactured, packed on, etc.
    Prefer preserving rawText. Only set isoDate when confident.
    """)
    var dateInfo: [DateInfo]?
}





