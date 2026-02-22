//
//  FieldConfidence.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Confidence wrapper for extracted field values.
//

import Foundation

struct FieldConfidence<Value: Sendable & Equatable>: Sendable, Equatable {
    var value: Value?
    var confidence: Double?
    var rawText: String?

    init(value: Value? = nil, confidence: Double? = nil, rawText: String? = nil) {
        self.value = value
        self.confidence = confidence
        self.rawText = rawText
    }
}

extension FieldConfidence: Codable where Value: Codable {}
extension FieldConfidence: Hashable where Value: Hashable {}
