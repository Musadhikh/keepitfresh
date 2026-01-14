//
//  Codable+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import Foundation
/// Errors specific to encoding an `Encodable` to a `[String: Any]` dictionary.
enum EncodingDictionaryError: Error {
    case topLevelNotDictionary
}

extension Encodable {
    /// A dictionary representation of this Encodable value.
    /// - Throws: An error if encoding fails or if the top-level JSON is not a dictionary.
    var asDictionary: [String: Any] {
        get throws {
            let data = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dict = json as? [String: Any] else {
                throw EncodingDictionaryError.topLevelNotDictionary
            }
            return dict
        }
    }

    /// A best-effort dictionary representation that returns an empty dictionary on failure.
    var dictionaryOrEmpty: [String: Any] {
        (try? asDictionary) ?? [:]
    }
}
