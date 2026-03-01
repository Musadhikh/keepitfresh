//
//  AppInventoryUndoService.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Restores exact inventory item snapshots and persists offline-first sync state.
//

import Foundation
import InventoryModule

protocol InventoryUndoServicing: Sendable {
    @discardableResult
    func restore(_ snapshot: InventoryModuleTypes.InventoryItem) async throws -> InventorySyncState
}

actor AppInventoryUndoService: InventoryUndoServicing {
    private let inventoryRepository: any InventoryModuleTypes.InventoryRepository
    private let remoteGateway: any InventoryModuleTypes.InventoryRemoteGateway
    private let syncStateStore: any InventoryModuleTypes.InventorySyncStateStore
    private let connectivity: any InventoryModuleTypes.ConnectivityProviding
    private let clock: any ClockProviding

    init(
        inventoryRepository: any InventoryModuleTypes.InventoryRepository,
        remoteGateway: any InventoryModuleTypes.InventoryRemoteGateway,
        syncStateStore: any InventoryModuleTypes.InventorySyncStateStore,
        connectivity: any InventoryModuleTypes.ConnectivityProviding,
        clock: any ClockProviding = InventoryModuleTypes.SystemClock()
    ) {
        self.inventoryRepository = inventoryRepository
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
    }

    @discardableResult
    func restore(_ snapshot: InventoryModuleTypes.InventoryItem) async throws -> InventorySyncState {
        try await inventoryRepository.upsert(snapshot)

        var metadata = InventorySyncMetadata(
            itemId: snapshot.id,
            householdId: snapshot.householdId,
            operation: .update,
            state: .pending,
            retryCount: 0,
            lastError: nil,
            lastAttemptAt: clock.now(),
            lastSyncedAt: nil,
            idempotencyRequestId: UUID().uuidString,
            addAction: nil
        )
        try await syncStateStore.upsertMetadata([metadata])

        guard await connectivity.isOnline() else {
            return .pending
        }

        do {
            try await remoteGateway.upsert([snapshot])
            metadata.state = .synced
            metadata.retryCount = 0
            metadata.lastError = nil
            metadata.lastAttemptAt = clock.now()
            metadata.lastSyncedAt = metadata.lastAttemptAt
            try await syncStateStore.upsertMetadata([metadata])
            return .synced
        } catch {
            metadata.state = .failed
            metadata.retryCount = 1
            metadata.lastError = error.localizedDescription
            metadata.lastAttemptAt = clock.now()
            try await syncStateStore.upsertMetadata([metadata])
            return .failed
        }
    }
}
