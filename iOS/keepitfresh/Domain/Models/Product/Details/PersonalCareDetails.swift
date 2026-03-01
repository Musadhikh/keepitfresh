//
//  PersonalCareDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable personal-care-specific detail fields.
//

import Foundation

struct PersonalCareDetail: Codable, Equatable, Sendable {
    var usageDirections: [String]?
    var ingredients: [String]?
    var warnings: [String]?
    var skinType: [String]?
}
