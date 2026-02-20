//
//  ProductDateInfo.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable parsed date metadata attached to products.
//

import Foundation

struct ProductDateInfo: Codable, Equatable, Sendable {
    var kind: Kind
    var rawText: String?
    var isoDate: Date?
    var confidence: Double?

    init(
        kind: Kind = .unknown,
        rawText: String? = nil,
        isoDate: Date? = nil,
        confidence: Double? = nil
    ) {
        self.kind = kind
        self.rawText = rawText
        self.isoDate = isoDate
        self.confidence = confidence
    }
}

extension ProductDateInfo {
    enum Kind: String, Codable, CaseIterable, Sendable {
        case expiry
        case bestBefore = "best_before"
        case useBy = "use_by"
        case manufactured
        case packedOn = "packed_on"
        case unknown
    }
}
