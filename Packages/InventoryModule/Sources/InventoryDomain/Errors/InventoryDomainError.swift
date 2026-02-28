//
//  InventoryDomainError.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Enumerates domain-level validation and business rule errors for inventory operations.
//

import Foundation

public enum InventoryDomainError: Error, Sendable, Equatable {
    case invalidQuantity
    case invalidHouseholdID
    case invalidProductID
    case invalidLocationID
    case incompatibleQuantityUnit
    case invalidWindowDays
    case itemNotFound
    case insufficientStock
    case invalidDateConfidence
}
