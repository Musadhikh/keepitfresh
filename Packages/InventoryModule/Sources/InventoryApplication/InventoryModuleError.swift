//
//  InventoryModuleError.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines application-layer errors surfaced by inventory service contracts.
//

import Foundation

public enum InventoryOperation: String, Sendable, Equatable {
    case addInventoryItem
    case consumeInventory
    case deleteInventoryItem
    case getExpiredItems
    case getExpiringItems
    case getInventorySummaryByProduct
}

public enum InventoryModuleError: Error, Sendable, Equatable {
    case connectivityUnavailable(operation: InventoryOperation)
}
