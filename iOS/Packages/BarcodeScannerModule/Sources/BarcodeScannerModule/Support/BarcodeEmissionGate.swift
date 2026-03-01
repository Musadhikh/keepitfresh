//
//  BarcodeEmissionGate.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Filters duplicate barcode events inside a short cooldown window to keep UI responsive.
//

import Foundation

struct BarcodeEmissionGate {
    private(set) var lastPayload: String?
    private(set) var lastEmissionDate: Date?
    private let duplicateFilterInterval: TimeInterval

    init(duplicateFilterInterval: TimeInterval) {
        self.duplicateFilterInterval = duplicateFilterInterval
    }

    mutating func shouldEmit(payload: String, now: Date = .now) -> Bool {
        if let lastPayload,
           let lastEmissionDate,
           lastPayload == payload,
           now.timeIntervalSince(lastEmissionDate) < duplicateFilterInterval {
            return false
        }

        self.lastPayload = payload
        self.lastEmissionDate = now
        return true
    }
}
