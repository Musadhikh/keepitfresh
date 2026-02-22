//
//  ProductBarcode.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable barcode domain model.
//

import Foundation

struct Barcode: Codable, Equatable, Hashable, Sendable {
    var value: String
    var symbology: Symbology
}

extension Barcode {
    enum Symbology: String, Codable, CaseIterable, Hashable, Sendable {
        case ean13
        case ean8
        case upcA = "upc_a"
        case upcE = "upc_e"
        case qr
        case code128
        case unknown
    }
}
