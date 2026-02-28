//
//  AppInventoryModuleService.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: App-layer service adapter that composes InventoryModule use cases behind InventoryModuleServicing.
//

import Foundation
import InventoryModule


actor AppInventoryModuleService: InventoryModuleTypes.InventoryModuleServicing {
    private let addUseCase: any InventoryModuleTypes.AddInventoryItemUseCase
    private let consumeUseCase: any InventoryModuleTypes.ConsumeInventoryUseCase
    private let moveUseCase: any InventoryModuleTypes.MoveInventoryItemLocationUseCase
    private let updateDatesUseCase: any InventoryModuleTypes.UpdateInventoryItemDatesUseCase
    private let getExpiredUseCase: any InventoryModuleTypes.GetExpiredItemsUseCase
    private let getExpiringUseCase: any InventoryModuleTypes.GetExpiringItemsUseCase
    private let summaryUseCase: any InventoryModuleTypes.GetInventorySummaryByProductUseCase
    private let syncPendingUseCase: any InventoryModuleTypes.SyncPendingInventoryUseCase
    private let warmupUseCase: any InventoryModuleTypes.WarmExpiringInventoryWindowUseCase

    init(
        addUseCase: any InventoryModuleTypes.AddInventoryItemUseCase,
        consumeUseCase: any InventoryModuleTypes.ConsumeInventoryUseCase,
        moveUseCase: any InventoryModuleTypes.MoveInventoryItemLocationUseCase,
        updateDatesUseCase: any InventoryModuleTypes.UpdateInventoryItemDatesUseCase,
        getExpiredUseCase: any InventoryModuleTypes.GetExpiredItemsUseCase,
        getExpiringUseCase: any InventoryModuleTypes.GetExpiringItemsUseCase,
        summaryUseCase: any InventoryModuleTypes.GetInventorySummaryByProductUseCase,
        syncPendingUseCase: any InventoryModuleTypes.SyncPendingInventoryUseCase,
        warmupUseCase: any InventoryModuleTypes.WarmExpiringInventoryWindowUseCase
    ) {
        self.addUseCase = addUseCase
        self.consumeUseCase = consumeUseCase
        self.moveUseCase = moveUseCase
        self.updateDatesUseCase = updateDatesUseCase
        self.getExpiredUseCase = getExpiredUseCase
        self.getExpiringUseCase = getExpiringUseCase
        self.summaryUseCase = summaryUseCase
        self.syncPendingUseCase = syncPendingUseCase
        self.warmupUseCase = warmupUseCase
    }

    func addInventoryItem(_ input: InventoryModuleTypes.AddInventoryItemInput) async throws -> InventoryModuleTypes.AddInventoryItemOutput {
        try await addUseCase.execute(input)
    }

    func consumeInventory(_ input: InventoryModuleTypes.ConsumeInventoryInput) async throws -> InventoryModuleTypes.ConsumeInventoryOutput {
        try await consumeUseCase.execute(input)
    }

    func moveInventoryItemLocation(_ input: InventoryModuleTypes.MoveInventoryItemLocationInput) async throws -> InventoryModuleTypes.MoveInventoryItemLocationOutput {
        try await moveUseCase.execute(input)
    }

    func updateInventoryItemDates(_ input: InventoryModuleTypes.UpdateInventoryItemDatesInput) async throws -> InventoryModuleTypes.UpdateInventoryItemDatesOutput {
        try await updateDatesUseCase.execute(input)
    }

    func getExpiredItems(_ input: InventoryModuleTypes.GetExpiredItemsInput) async throws -> [InventoryModuleTypes.InventoryItem] {
        try await getExpiredUseCase.execute(input)
    }

    func getExpiringItems(_ input: InventoryModuleTypes.GetExpiringItemsInput) async throws -> [InventoryModuleTypes.InventoryItem] {
        try await getExpiringUseCase.execute(input)
    }

    func getInventorySummaryByProduct(_ input: InventoryModuleTypes.GetInventorySummaryByProductInput) async throws -> InventoryModuleTypes.InventoryProductSummary {
        try await summaryUseCase.execute(input)
    }

    func syncPendingInventory(_ input: InventoryModuleTypes.SyncPendingInventoryInput) async throws -> InventoryModuleTypes.SyncPendingInventoryOutput {
        try await syncPendingUseCase.execute(input)
    }

    func warmExpiringInventoryWindow(_ input: InventoryModuleTypes.WarmExpiringInventoryWindowInput) async throws -> InventoryModuleTypes.WarmExpiringInventoryWindowOutput {
        try await warmupUseCase.execute(input)
    }
}
