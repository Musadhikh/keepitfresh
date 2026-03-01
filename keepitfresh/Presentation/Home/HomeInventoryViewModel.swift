//
//  HomeInventoryViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Loads expired/expiring inventory alerts through InventoryModule query APIs.
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
    @Injected(\.inventoryModuleService)
    private var inventoryModuleService: any InventoryModuleTypes.InventoryModuleServicing

    private(set) var expiredItems: [InventoryModuleTypes.InventoryItem] = []
    private(set) var expiringItems: [InventoryModuleTypes.InventoryItem] = []
    private(set) var isLoading = false
    private(set) var loadErrorMessage: String?

    func loadInventory(householdId: String?) async {
        guard isLoading == false else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            guard let householdId, householdId.isEmpty == false else {
                expiredItems = []
                expiringItems = []
                loadErrorMessage = nil
                return
            }

            let now = Date()
            let timeZone = TimeZone.current

            _ = try? await inventoryModuleService.warmExpiringInventoryWindow(
                InventoryModuleTypes.WarmExpiringInventoryWindowInput(
                    householdId: householdId,
                    today: now,
                    windowDays: 14,
                    timeZone: timeZone,
                    launchId: Self.homeLaunchWarmupID
                )
            )

            async let expired = inventoryModuleService.getExpiredItems(
                InventoryModuleTypes.GetExpiredItemsInput(
                    householdId: householdId,
                    today: now,
                    timeZone: timeZone
                )
            )
            async let expiring = inventoryModuleService.getExpiringItems(
                InventoryModuleTypes.GetExpiringItemsInput(
                    householdId: householdId,
                    today: now,
                    windowDays: 14,
                    timeZone: timeZone
                )
            )

            let (expiredResult, expiringResult) = try await (expired, expiring)
            expiredItems = expiredResult.sorted(by: inventorySortComparator)
            expiringItems = expiringResult.sorted(by: inventorySortComparator)
            loadErrorMessage = nil
        } catch {
            expiredItems = []
            expiringItems = []
            loadErrorMessage = "Unable to load inventory alerts."
        }
    }

    private func inventorySortComparator(
        lhs: InventoryModuleTypes.InventoryItem,
        rhs: InventoryModuleTypes.InventoryItem
    ) -> Bool {
        let lhsDate = lhs.expiryInfo?.isoDate ?? .distantFuture
        let rhsDate = rhs.expiryInfo?.isoDate ?? .distantFuture

        if lhsDate != rhsDate {
            return lhsDate < rhsDate
        }
        return lhs.id < rhs.id
    }
}
