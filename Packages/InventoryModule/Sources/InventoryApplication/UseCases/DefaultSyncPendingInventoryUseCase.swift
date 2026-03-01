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
    private let retryPolicy: any InventorySyncRetryPolicy
    private let observability: any InventorySyncObservability

    public init(
        inventoryRepository: any InventoryRepository,
        remoteGateway: any InventoryRemoteGateway,
        syncStateStore: any InventorySyncStateStore,
        connectivity: any ConnectivityProviding,
        clock: any ClockProviding = SystemClock(),
        retryPolicy: any InventorySyncRetryPolicy = DefaultInventorySyncRetryPolicy(),
        observability: any InventorySyncObservability = NoOpInventorySyncObservability()
    ) {
        self.inventoryRepository = inventoryRepository
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
        self.retryPolicy = retryPolicy
        self.observability = observability
    }

    public func execute(_ input: SyncPendingInventoryInput) async throws -> SyncPendingInventoryOutput {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }

        await observability.record(.started(householdId: input.householdId))

        guard await connectivity.isOnline() else {
            await observability.record(.skippedOffline(householdId: input.householdId))
            return SyncPendingInventoryOutput(syncedCount: 0, failedCount: 0, skippedCount: 0)
        }

        var candidates = try await syncStateStore.fetchByState(
            householdId: input.householdId,
            state: .pending,
            limit: input.limit
        )
        let failed = try await syncStateStore.fetchByState(
            householdId: input.householdId,
            state: .failed,
            limit: input.limit
        )
        candidates.append(contentsOf: failed)

        var syncedCount = 0
        var failedCount = 0
        var skippedCount = 0
        var attemptedCount = 0
        let now = clock.now()

        for metadata in candidates {
            guard retryPolicy.shouldAttempt(metadata, now: now) else {
                skippedCount += 1
                await observability.record(
                    .itemSkipped(
                        itemId: metadata.itemId,
                        operation: metadata.operation,
                        reason: "retry_backoff_or_limit"
                    )
                )
                continue
            }

            guard let item = try await inventoryRepository.findById(metadata.itemId, householdId: metadata.householdId) else {
                skippedCount += 1
                await observability.record(
                    .itemSkipped(
                        itemId: metadata.itemId,
                        operation: metadata.operation,
                        reason: "missing_local_item"
                    )
                )
                continue
            }

            attemptedCount += 1
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
                await observability.record(.itemSynced(itemId: metadata.itemId, operation: metadata.operation))
            } catch {
                var updated = metadata
                updated.state = .failed
                updated.retryCount += 1
                updated.lastError = error.localizedDescription
                updated.lastAttemptAt = clock.now()
                try await syncStateStore.upsertMetadata([updated])
                failedCount += 1
                await observability.record(
                    .itemFailed(
                        itemId: metadata.itemId,
                        operation: metadata.operation,
                        category: classifyFailure(error)
                    )
                )
            }
        }

        await observability.record(
            .completed(
                householdId: input.householdId,
                attempted: attemptedCount,
                synced: syncedCount,
                failed: failedCount,
                skipped: skippedCount
            )
        )

        return SyncPendingInventoryOutput(
            syncedCount: syncedCount,
            failedCount: failedCount,
            skippedCount: skippedCount
        )
    }
}

private extension DefaultSyncPendingInventoryUseCase {
    func classifyFailure(_ error: Error) -> InventorySyncFailureCategory {
        let message = error.localizedDescription.lowercased()
        if message.contains("conflict") || message.contains("version") || message.contains("409") {
            return .conflict
        }
        if message.contains("network")
            || message.contains("timeout")
            || message.contains("unavailable")
            || message.contains("temporary")
        {
            return .transient
        }
        if message.contains("invalid")
            || message.contains("validation")
            || message.contains("permission")
        {
            return .validation
        }
        return .unknown
    }
}
