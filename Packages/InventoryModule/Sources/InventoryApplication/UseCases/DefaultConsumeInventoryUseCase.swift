//
//  DefaultConsumeInventoryUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements FEFO consumption with offline-first local mutation and sync-state tracking.
//

import Foundation
import InventoryDomain

public actor DefaultConsumeInventoryUseCase: ConsumeInventoryUseCase {
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

    public func execute(_ input: ConsumeInventoryInput) async throws -> ConsumeInventoryOutput {
        try validate(input)

        let (householdId, selectedBatches) = try await resolveTargetBatches(input.target)
        let sorted = FEFOSelectionPolicy.sortForConsumption(selectedBatches.filter { $0.status == .active })

        var remaining = input.amount.value
        let now = clock.now()
        var consumedResults: [ConsumedBatchResult] = []
        var updatedBatches: [InventoryItem] = []

        for batch in sorted where remaining > 0 {
            let available = batch.quantity.value
            guard available > 0 else { continue }

            let consumed = min(available, remaining)
            var updated = batch
            updated.quantity.value = max(0, available - consumed)
            updated.updatedAt = now

            if updated.quantity.value == 0 {
                updated.status = .consumed
                updated.consumedAt = now
            }

            consumedResults.append(
                ConsumedBatchResult(
                    inventoryItemId: batch.id,
                    consumedQuantity: Quantity(value: consumed, unit: input.amount.unit),
                    remainingQuantity: updated.quantity
                )
            )
            updatedBatches.append(updated)
            remaining -= consumed
        }

        guard !updatedBatches.isEmpty else {
            return ConsumeInventoryOutput(
                consumed: [],
                remainingRequestedAmount: input.amount,
                syncState: .pending
            )
        }

        try await inventoryRepository.updateMany(updatedBatches)

        var metadata = updatedBatches.map { item in
            InventorySyncMetadata(
                itemId: item.id,
                householdId: householdId,
                operation: .consume,
                state: .pending,
                retryCount: 0,
                lastError: nil,
                lastAttemptAt: now,
                lastSyncedAt: nil,
                idempotencyRequestId: input.idempotencyRequestId,
                addAction: nil
            )
        }
        try await syncStateStore.upsertMetadata(metadata)

        guard await connectivity.isOnline() else {
            return ConsumeInventoryOutput(
                consumed: consumedResults,
                remainingRequestedAmount: Quantity(value: remaining, unit: input.amount.unit),
                syncState: .pending
            )
        }

        do {
            try await remoteGateway.upsert(updatedBatches)
            let syncedAt = clock.now()
            metadata = metadata.map { item in
                var updated = item
                updated.state = .synced
                updated.retryCount = 0
                updated.lastError = nil
                updated.lastAttemptAt = syncedAt
                updated.lastSyncedAt = syncedAt
                return updated
            }
            try await syncStateStore.upsertMetadata(metadata)
            return ConsumeInventoryOutput(
                consumed: consumedResults,
                remainingRequestedAmount: Quantity(value: remaining, unit: input.amount.unit),
                syncState: .synced
            )
        } catch {
            let failedAt = clock.now()
            metadata = metadata.map { item in
                var updated = item
                updated.state = .failed
                updated.retryCount = 1
                updated.lastError = error.localizedDescription
                updated.lastAttemptAt = failedAt
                return updated
            }
            try await syncStateStore.upsertMetadata(metadata)
            return ConsumeInventoryOutput(
                consumed: consumedResults,
                remainingRequestedAmount: Quantity(value: remaining, unit: input.amount.unit),
                syncState: .failed
            )
        }
    }
}

private extension DefaultConsumeInventoryUseCase {
    func validate(_ input: ConsumeInventoryInput) throws {
        if input.amount.value <= 0 {
            throw InventoryDomainError.invalidQuantity
        }

        switch input.target {
        case let .inventoryItemId(itemId, householdId):
            if itemId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw InventoryDomainError.itemNotFound
            }
            if householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw InventoryDomainError.invalidHouseholdID
            }
        case let .productId(productId, householdId):
            if productId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw InventoryDomainError.invalidProductID
            }
            if householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw InventoryDomainError.invalidHouseholdID
            }
        }
    }

    func resolveTargetBatches(_ target: ConsumeInventoryTarget) async throws -> (householdId: String, batches: [InventoryItem]) {
        switch target {
        case let .inventoryItemId(itemId, householdId):
            guard let item = try await inventoryRepository.findById(itemId, householdId: householdId) else {
                throw InventoryDomainError.itemNotFound
            }
            return (householdId, [item])
        case let .productId(productId, householdId):
            let batches = try await inventoryRepository.fetchActiveBatches(productId: productId, householdId: householdId)
            return (householdId, batches)
        }
    }
}

