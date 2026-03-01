//
//  HouseholdDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable household-specific detail fields.
//

import Foundation

struct HouseholdDetail: Codable, Equatable, Sendable {
    var usageInstructions: [String]
    var safetyWarnings: [String]
    var materials: [String]
}
