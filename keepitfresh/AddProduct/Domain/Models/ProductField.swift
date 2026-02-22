//
//  ProductField.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Field-level edit/lock and confidence keys for Add Product review UI.
//

import Foundation

enum ProductField: String, Codable, Sendable, Equatable, Hashable, CaseIterable {
    case barcode
    case title
    case brand
    case description
    case categories
    case size
    case images
    case quantity
    case unit
    case dateInfo
    case notes
}
