//
//
//  DateInfo.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: DateInfo
//
    
import FoundationModels

@Generable
struct DateInfo: Equatable, Sendable, ModelStringConvertible {
    @Guide(description: "Date kind (expiry, best_before, use_by, manufactured, packed_on, prod date, pkd, use by, etc.).")
    var kind: DateKind?
    
    @Guide(description: "Date string exactly as printed (do not normalize).")
    var rawText: String?
    
    @Guide(description: "Normalized ISO date if confidently derivable, e.g. '2026-03-31'.")
    var isoDate: String?
    
    @Guide(description: "Confidence 0.0 to 1.0 for the normalized ISO date.")
    var isoConfidence: Double?
}

@Generable
enum DateKind: String, CaseIterable, Sendable, ModelStringConvertible {
    case expiry
    case best_before
    case use_by
    case manufactured
    case packed_on
    case unknown
}
