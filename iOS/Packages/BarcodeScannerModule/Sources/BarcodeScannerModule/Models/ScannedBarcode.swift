//
//  ScannedBarcode.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Defines the plain DTO returned by live barcode scanning callbacks.
//

import Foundation

public struct ScannedBarcode: Equatable, Sendable, Identifiable {
    public let id: UUID
    public let payload: String
    public let symbology: String
    public let scannedAt: Date

    public init(
        id: UUID = UUID(),
        payload: String,
        symbology: String,
        scannedAt: Date = .now
    ) {
        self.id = id
        self.payload = payload
        self.symbology = symbology
        self.scannedAt = scannedAt
    }
}
