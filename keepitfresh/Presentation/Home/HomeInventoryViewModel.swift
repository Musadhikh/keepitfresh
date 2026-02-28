//
//  HomeInventoryViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Loads and exposes local Realm inventory items for Home screen rendering.
//

import Factory
import Foundation
import InventoryModule
import Observation


@MainActor
@Observable
final class HomeInventoryViewModel {
    private static let homeLaunchWarmupID = UUID().uuidString

    @ObservationIgnored
    @Injected(\.addProductInventoryRepository)
    private var inventoryRepository: any InventoryRepository

    @ObservationIgnored
    @Injected(\.inventoryModuleService)
    private var inventoryModuleService: any InventoryModuleTypes.InventoryModuleServicing

    private(set) var inventoryItems: [InventoryItem] = []
    private(set) var isLoading = false
    private(set) var loadErrorMessage: String?

    func loadInventory(householdId: String?) async {
        guard isLoading == false else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            if let householdId, householdId.isEmpty == false {
                try? await inventoryModuleService.warmExpiringInventoryWindow(
                    InventoryModuleTypes.WarmExpiringInventoryWindowInput(
                        householdId: householdId,
                        today: Date(),
                        windowDays: 14,
                        timeZone: .current,
                        launchId: Self.homeLaunchWarmupID
                    )
                )
            }

            let items = try await inventoryRepository.fetchAllLocal(householdId: householdId)
            inventoryItems = items.sorted(by: inventorySortComparator)
            loadErrorMessage = nil
        } catch {
            inventoryItems = []
            loadErrorMessage = "Unable to load local inventory."
        }
    }

    private func inventorySortComparator(lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        let lhsDate = lhs.updatedAt ?? .distantPast
        let rhsDate = rhs.updatedAt ?? .distantPast

        if lhsDate != rhsDate {
            return lhsDate > rhsDate
        }
        return lhs.id < rhs.id
    }
}
