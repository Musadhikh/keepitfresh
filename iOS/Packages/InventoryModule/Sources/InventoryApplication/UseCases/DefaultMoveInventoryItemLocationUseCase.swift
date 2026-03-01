//
//  DefaultMoveInventoryItemLocationUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements offline-first inventory location move behavior with sync-state tracking.
//

import Foundation
import InventoryDomain

public actor DefaultMoveInventoryItemLocationUseCase: MoveInventoryItemLocationUseCase {
    private let inventoryRepository: any InventoryRepository
    private let locationRepository: any LocationRepository
    private let remoteGateway: any InventoryRemoteGateway
    private let syncStateStore: any InventorySyncStateStore
    private let connectivity: any ConnectivityProviding
    private let clock: any ClockProviding

    public init(
        inventoryRepository: any InventoryRepository,
        locationRepository: any LocationRepository,
        remoteGateway: any InventoryRemoteGateway,
        syncStateStore: any InventorySyncStateStore,
        connectivity: any ConnectivityProviding,
        clock: any ClockProviding = SystemClock()
    ) {
        self.inventoryRepository = inventoryRepository
        self.locationRepository = locationRepository
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
    }

    public func execute(_ input: MoveInventoryItemLocationInput) async throws -> MoveInventoryItemLocationOutput {
        try validate(input)

        if let existing = try await resolveIdempotentResult(input) {
            return existing
        }

        guard try await locationRepository.findById(input.targetLocationId, householdId: input.householdId) != nil else {
            throw InventoryDomainError.invalidLocationID
        }

        guard var item = try await inventoryRepository.findById(input.itemId, householdId: input.householdId) else {
            throw InventoryDomainError.itemNotFound
        }

        item.storageLocationId = input.targetLocationId
        item.updatedAt = clock.now()
        try await inventoryRepository.upsert(item)

        var metadata = InventorySyncMetadata(
            itemId: item.id,
            householdId: input.householdId,
            operation: .update,
            state: .pending,
            retryCount: 0,
            lastError: nil,
            lastAttemptAt: clock.now(),
            lastSyncedAt: nil,
            idempotencyRequestId: input.idempotencyRequestId,
            addAction: nil
        )
        try await syncStateStore.upsertMetadata([metadata])

        guard await connectivity.isOnline() else {
            return MoveInventoryItemLocationOutput(item: item, syncState: .pending)
        }

        do {
            try await remoteGateway.upsert([item])
            metadata.state = .synced
            metadata.retryCount = 0
            metadata.lastError = nil
            metadata.lastAttemptAt = clock.now()
            metadata.lastSyncedAt = metadata.lastAttemptAt
            try await syncStateStore.upsertMetadata([metadata])
            return MoveInventoryItemLocationOutput(item: item, syncState: .synced)
        } catch {
            metadata.state = .failed
            metadata.retryCount = 1
            metadata.lastError = error.localizedDescription
            metadata.lastAttemptAt = clock.now()
            try await syncStateStore.upsertMetadata([metadata])
            return MoveInventoryItemLocationOutput(item: item, syncState: .failed)
        }
    }
}

private extension DefaultMoveInventoryItemLocationUseCase {
    func validate(_ input: MoveInventoryItemLocationInput) throws {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.itemId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.itemNotFound
        }
        if input.targetLocationId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidLocationID
        }
    }

    func resolveIdempotentResult(_ input: MoveInventoryItemLocationInput) async throws -> MoveInventoryItemLocationOutput? {
        guard let requestID = input.idempotencyRequestId else {
            return nil
        }
        guard let metadata = try await syncStateStore.metadata(
            forRequestId: requestID,
            householdId: input.householdId,
            operation: .update
        ) else {
            return nil
        }
        guard let existing = try await inventoryRepository.findById(metadata.itemId, householdId: input.householdId) else {
            return nil
        }
        return MoveInventoryItemLocationOutput(item: existing, syncState: metadata.state)
    }
}

