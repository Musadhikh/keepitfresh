//
//  DefaultSyncPendingInventoryUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Syncs pending local inventory mutations to remote and updates sync-state metadata.
//

import Foundation
import InventoryDomain

public actor DefaultSyncPendingInventoryUseCase: SyncPendingInventoryUseCase {
    private let inventoryRepository: any InventoryRepository
    private let remoteGateway: any InventoryRemoteGateway
    private let syncStateStore: any InventorySyncStateStore
    private let connectivity: any ConnectivityProviding
    private let clock: any ClockProviding

    public init(
        inventoryRepository: any InventoryRepository,
        remoteGateway: any InventoryRemoteGateway,
        syncStateStore: any InventorySyncStateStore,
        connectivity: any ConnectivityProviding,
        clock: any ClockProviding = SystemClock()
    ) {
        self.inventoryRepository = inventoryRepository
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
    }

    public func execute(_ input: SyncPendingInventoryInput) async throws -> SyncPendingInventoryOutput {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }

        guard await connectivity.isOnline() else {
            return SyncPendingInventoryOutput(syncedCount: 0, failedCount: 0, skippedCount: 0)
        }

        let pending = try await syncStateStore.fetchByState(
            householdId: input.householdId,
            state: .pending,
            limit: input.limit
        )

        var syncedCount = 0
        var failedCount = 0
        var skippedCount = 0

        for metadata in pending {
            guard let item = try await inventoryRepository.findById(metadata.itemId, householdId: metadata.householdId) else {
                skippedCount += 1
                continue
            }

            do {
                try await remoteGateway.upsert([item])
                var updated = metadata
                let syncedAt = clock.now()
                updated.state = .synced
                updated.retryCount = 0
                updated.lastError = nil
                updated.lastAttemptAt = syncedAt
                updated.lastSyncedAt = syncedAt
                try await syncStateStore.upsertMetadata([updated])
                syncedCount += 1
            } catch {
                var updated = metadata
                updated.state = .failed
                updated.retryCount += 1
                updated.lastError = error.localizedDescription
                updated.lastAttemptAt = clock.now()
                try await syncStateStore.upsertMetadata([updated])
                failedCount += 1
            }
        }

        return SyncPendingInventoryOutput(
            syncedCount: syncedCount,
            failedCount: failedCount,
            skippedCount: skippedCount
        )
    }
}

