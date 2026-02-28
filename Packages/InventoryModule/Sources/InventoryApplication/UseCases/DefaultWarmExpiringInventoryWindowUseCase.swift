//
//  DefaultWarmExpiringInventoryWindowUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Performs one-time-per-launch expiring-window refresh into local cache.
//

import Foundation
import InventoryDomain

public actor DefaultWarmExpiringInventoryWindowUseCase: WarmExpiringInventoryWindowUseCase {
    private let inventoryRepository: any InventoryRepository
    private let remoteGateway: any InventoryRemoteGateway
    private let warmupRunStore: any InventoryWarmupRunStore
    private let connectivity: any ConnectivityProviding

    public init(
        inventoryRepository: any InventoryRepository,
        remoteGateway: any InventoryRemoteGateway,
        warmupRunStore: any InventoryWarmupRunStore,
        connectivity: any ConnectivityProviding
    ) {
        self.inventoryRepository = inventoryRepository
        self.remoteGateway = remoteGateway
        self.warmupRunStore = warmupRunStore
        self.connectivity = connectivity
    }

    public func execute(_ input: WarmExpiringInventoryWindowInput) async throws -> WarmExpiringInventoryWindowOutput {
        try validate(input)

        if try await warmupRunStore.hasRun(
            launchId: input.launchId,
            householdId: input.householdId,
            windowDays: input.windowDays
        ) {
            return WarmExpiringInventoryWindowOutput(didRun: false, refreshedCount: 0, expiringCount: 0)
        }

        var refreshedCount = 0
        if await connectivity.isOnline() {
            let remoteItems = try await remoteGateway.fetchActiveItems(householdId: input.householdId)
            try await inventoryRepository.updateMany(remoteItems)
            refreshedCount = remoteItems.count
        }

        let expiring = try await inventoryRepository.fetchExpiring(
            input.householdId,
            asOf: input.today,
            windowDays: input.windowDays,
            timeZone: input.timeZone
        )
        try await warmupRunStore.markRun(
            launchId: input.launchId,
            householdId: input.householdId,
            windowDays: input.windowDays
        )

        return WarmExpiringInventoryWindowOutput(
            didRun: true,
            refreshedCount: refreshedCount,
            expiringCount: expiring.count
        )
    }
}

private extension DefaultWarmExpiringInventoryWindowUseCase {
    func validate(_ input: WarmExpiringInventoryWindowInput) throws {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.launchId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidLaunchID
        }
        if input.windowDays < 0 {
            throw InventoryDomainError.invalidWindowDays
        }
    }
}
