//
//  ProductIdentity.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Provides normalization helpers for enforcing product identity invariants.
//

import Foundation

public enum ProductIdentity {
    public static func normalizeBarcode(_ rawValue: String?) -> String? {
        guard let rawValue else { return nil }
        let trimmed = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.isEmpty == false else { return nil }

        let allowedScalars = trimmed.unicodeScalars.filter {
            CharacterSet.alphanumerics.contains($0)
        }
        let normalized = String(String.UnicodeScalarView(allowedScalars)).uppercased()

        return normalized.isEmpty ? nil : normalized
    }

    public static func normalizedProductID(from productID: String) -> String {
        productID.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
