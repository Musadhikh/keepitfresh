//
//  UnknownDetails.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Fallback payload for unknown or un-decodable detail data.
//

import Foundation

struct UnknownDetails: Codable, Equatable, Sendable {
    var raw: [String: String]?

    static let empty = UnknownDetails(raw: nil)
}
