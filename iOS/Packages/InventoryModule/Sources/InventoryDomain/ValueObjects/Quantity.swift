//
//  Quantity.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Represents inventory quantity amount and unit.
//

import Foundation

public enum QuantityUnit: String, Sendable, Codable, Equatable, Hashable {
    case piece
    case gram
    case kilogram
    case milliliter
    case liter
    case pack
}

public struct Quantity: Sendable, Codable, Equatable, Hashable {
    public var value: Double
    public var unit: QuantityUnit

    public init(value: Double, unit: QuantityUnit) {
        self.value = value
        self.unit = unit
    }
}

