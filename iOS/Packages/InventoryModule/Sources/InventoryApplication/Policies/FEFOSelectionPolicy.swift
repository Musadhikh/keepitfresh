//
//  FEFOSelectionPolicy.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides deterministic sorting helper for FEFO batch selection.
//

import Foundation
import InventoryDomain

public enum FEFOSelectionPolicy {
    public static func sortForConsumption(_ items: [InventoryItem]) -> [InventoryItem] {
        items.sorted { lhs, rhs in
            let lhsExpiry = lhs.expiryInfo?.isoDate
            let rhsExpiry = rhs.expiryInfo?.isoDate
            switch (lhsExpiry, rhsExpiry) {
            case let (l?, r?):
                if l != r { return l < r }
            case (_?, nil):
                return true
            case (nil, _?):
                return false
            case (nil, nil):
                break
            }
            return lhs.createdAt < rhs.createdAt
        }
    }
}

