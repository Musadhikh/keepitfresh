//
//  DefaultUpdateInventoryItemDatesUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements offline-first inventory date metadata updates with sync-state tracking.
//

import Foundation
import InventoryDomain

public actor DefaultUpdateInventoryItemDatesUseCase: UpdateInventoryItemDatesUseCase {
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

    public func execute(_ input: UpdateInventoryItemDatesInput) async throws -> UpdateInventoryItemDatesOutput {
        try validate(input)

        if let existing = try await resolveIdempotentResult(input) {
            return existing
        }

        guard var item = try await inventoryRepository.findById(input.itemId, householdId: input.householdId) else {
            throw InventoryDomainError.itemNotFound
        }

        item.expiryInfo = input.expiryInfo
        item.openedInfo = input.openedInfo
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
            return UpdateInventoryItemDatesOutput(item: item, syncState: .pending)
        }

        do {
            try await remoteGateway.upsert([item])
            metadata.state = .synced
            metadata.retryCount = 0
            metadata.lastError = nil
            metadata.lastAttemptAt = clock.now()
            metadata.lastSyncedAt = metadata.lastAttemptAt
            try await syncStateStore.upsertMetadata([metadata])
            return UpdateInventoryItemDatesOutput(item: item, syncState: .synced)
        } catch {
            metadata.state = .failed
            metadata.retryCount = 1
            metadata.lastError = error.localizedDescription
            metadata.lastAttemptAt = clock.now()
            try await syncStateStore.upsertMetadata([metadata])
            return UpdateInventoryItemDatesOutput(item: item, syncState: .failed)
        }
    }
}

private extension DefaultUpdateInventoryItemDatesUseCase {
    func validate(_ input: UpdateInventoryItemDatesInput) throws {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.itemId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.itemNotFound
        }
        if let expiry = input.expiryInfo, !(0...1).contains(expiry.confidence) {
            throw InventoryDomainError.invalidDateConfidence
        }
        if let opened = input.openedInfo, !(0...1).contains(opened.confidence) {
            throw InventoryDomainError.invalidDateConfidence
        }
    }

    func resolveIdempotentResult(_ input: UpdateInventoryItemDatesInput) async throws -> UpdateInventoryItemDatesOutput? {
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
        return UpdateInventoryItemDatesOutput(item: existing, syncState: metadata.state)
    }
}

