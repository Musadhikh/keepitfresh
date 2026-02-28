//
//  InventoryDateInfo.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Captures extracted/raw date metadata used for inventory lifecycle decisions.
//

import Foundation

public enum InventoryDateKind: String, Sendable, Codable, Equatable, Hashable {
    case expiry
    case opened
    case bestBefore
    case useBy
    case manufactured
    case packaged
}

public struct InventoryDateInfo: Sendable, Codable, Equatable, Hashable {
    public var kind: InventoryDateKind
    public var rawText: String
    public var confidence: Double
    public var isoDate: Date?

    public init(kind: InventoryDateKind, rawText: String, confidence: Double, isoDate: Date?) {
        self.kind = kind
        self.rawText = rawText
        self.confidence = confidence
        self.isoDate = isoDate
    }
}

