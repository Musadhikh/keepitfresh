//
//  InventoryModuleServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares the module-level inventory business operations for app integration.
//

import Foundation
import InventoryDomain

public protocol InventoryModuleServicing: Sendable {
    func addInventoryItem(_ input: AddInventoryItemInput) async throws -> AddInventoryItemOutput
    func consumeInventory(_ input: ConsumeInventoryInput) async throws -> ConsumeInventoryOutput
    func moveInventoryItemLocation(_ input: MoveInventoryItemLocationInput) async throws -> MoveInventoryItemLocationOutput
    func updateInventoryItemDates(_ input: UpdateInventoryItemDatesInput) async throws -> UpdateInventoryItemDatesOutput
    func getExpiredItems(_ input: GetExpiredItemsInput) async throws -> [InventoryItem]
    func getExpiringItems(_ input: GetExpiringItemsInput) async throws -> [InventoryItem]
    func getInventorySummaryByProduct(_ input: GetInventorySummaryByProductInput) async throws -> InventoryProductSummary
}

