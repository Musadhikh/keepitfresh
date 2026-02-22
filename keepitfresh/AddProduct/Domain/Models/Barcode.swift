//
//  Barcode.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Add Product bridge helpers that reuse the shared Barcode domain model.
//

import Foundation

extension Barcode {
    init(value: String, symbologyLabel: String?) {
        self.value = value
        self.symbology = Self.mapSymbology(from: symbologyLabel)
    }

    var symbologyLabel: String? {
        symbology == .unknown ? nil : symbology.rawValue
    }

    private static func mapSymbology(from label: String?) -> Symbology {
        guard let label else { return .unknown }
        switch label.lowercased() {
        case "ean13", "ean-13":
            return .ean13
        case "ean8", "ean-8":
            return .ean8
        case "upca", "upc-a", "upc_a":
            return .upcA
        case "upce", "upc-e", "upc_e":
            return .upcE
        case "qr", "qrcode":
            return .qr
        case "code128", "code-128":
            return .code128
        default:
            return .unknown
        }
    }
}
