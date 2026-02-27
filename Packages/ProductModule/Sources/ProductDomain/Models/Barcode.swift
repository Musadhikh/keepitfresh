//
//  Barcode.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines normalized barcode identity and supported symbologies for products.
//

import Foundation

public struct Barcode: Sendable, Codable, Equatable, Hashable {
    public var value: String
    public var symbology: Symbology

    public init(value: String, symbology: Symbology) {
        self.value = value
        self.symbology = symbology
    }
}

public extension Barcode {
    enum Symbology: String, Codable, CaseIterable, Sendable {
        case ean13
        case ean8
        case upcA = "upc_a"
        case upcE = "upc_e"
        case qr
        case code128
        case unknown
    }
}
