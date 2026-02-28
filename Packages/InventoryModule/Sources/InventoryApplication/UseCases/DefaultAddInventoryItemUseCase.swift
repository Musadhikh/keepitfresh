//
//  DefaultAddInventoryItemUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements offline-first add inventory behavior with merge-or-create and sync-state tracking.
//

import Foundation
import InventoryDomain

public actor DefaultAddInventoryItemUseCase: AddInventoryItemUseCase {
    private let inventoryRepository: any InventoryRepository
    private let locationRepository: any LocationRepository
    private let remoteGateway: any InventoryRemoteGateway
    private let syncStateStore: any InventorySyncStateStore
    private let connectivity: any ConnectivityProviding
    private let clock: any ClockProviding
    private let idGenerator: @Sendable () -> String

    public init(
        inventoryRepository: any InventoryRepository,
        locationRepository: any LocationRepository,
        remoteGateway: any InventoryRemoteGateway,
        syncStateStore: any InventorySyncStateStore,
        connectivity: any ConnectivityProviding,
        clock: any ClockProviding = SystemClock(),
        idGenerator: @escaping @Sendable () -> String = { UUID().uuidString }
    ) {
        self.inventoryRepository = inventoryRepository
        self.locationRepository = locationRepository
        self.remoteGateway = remoteGateway
        self.syncStateStore = syncStateStore
        self.connectivity = connectivity
        self.clock = clock
        self.idGenerator = idGenerator
    }

    public func execute(_ input: AddInventoryItemInput) async throws -> AddInventoryItemOutput {
        try validate(input)
        try await validateLocation(input)

        if let existing = try await resolveIdempotentResult(input) {
            return existing
        }

        let now = clock.now()
        let mergeKey = InventoryMergeKey(
            householdId: input.householdId,
            productId: input.productRef.productId,
            expiryDate: input.expiryInfo?.isoDate,
            openedAt: input.openedInfo?.isoDate,
            storageLocationId: input.storageLocationId,
            lotOrBatchCode: input.lotOrBatchCode
        )

        let item: InventoryItem
        let action: InventoryAddAction

        if let existing = try await inventoryRepository.findMergeCandidate(mergeKey) {
            guard existing.quantity.unit == input.quantity.unit else {
                throw InventoryDomainError.incompatibleQuantityUnit
            }

            var merged = existing
            merged.quantity.value += input.quantity.value
            merged.updatedAt = now
            try await inventoryRepository.upsert(merged)
            item = merged
            action = .merged
        } else {
            let created = InventoryItem(
                id: idGenerator(),
                householdId: input.householdId,
                productRef: input.productRef,
                quantity: input.quantity,
                status: .active,
                storageLocationId: input.storageLocationId,
                lotOrBatchCode: input.lotOrBatchCode,
                expiryInfo: input.expiryInfo,
                openedInfo: input.openedInfo,
                createdAt: now,
                updatedAt: now
            )
            try await inventoryRepository.create(created)
            item = created
            action = .created
        }

        var metadata = InventorySyncMetadata(
            itemId: item.id,
            householdId: input.householdId,
            operation: .add,
            state: .pending,
            retryCount: 0,
            lastError: nil,
            lastAttemptAt: now,
            lastSyncedAt: nil,
            idempotencyRequestId: input.idempotencyRequestId,
            addAction: action
        )

        try await syncStateStore.upsertMetadata([metadata])

        guard await connectivity.isOnline() else {
            return AddInventoryItemOutput(itemId: item.id, action: action, item: item, syncState: .pending)
        }

        do {
            try await remoteGateway.upsert([item])
            metadata.state = .synced
            metadata.retryCount = 0
            metadata.lastError = nil
            metadata.lastAttemptAt = clock.now()
            metadata.lastSyncedAt = metadata.lastAttemptAt
            try await syncStateStore.upsertMetadata([metadata])
            return AddInventoryItemOutput(itemId: item.id, action: action, item: item, syncState: .synced)
        } catch {
            metadata.state = .failed
            metadata.retryCount = 1
            metadata.lastError = error.localizedDescription
            metadata.lastAttemptAt = clock.now()
            try await syncStateStore.upsertMetadata([metadata])
            return AddInventoryItemOutput(itemId: item.id, action: action, item: item, syncState: .failed)
        }
    }
}

private extension DefaultAddInventoryItemUseCase {
    func validate(_ input: AddInventoryItemInput) throws {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.productRef.productId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidProductID
        }
        if input.storageLocationId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidLocationID
        }
        if input.quantity.value <= 0 {
            throw InventoryDomainError.invalidQuantity
        }
    }

    func validateLocation(_ input: AddInventoryItemInput) async throws {
        let location = try await locationRepository.findById(input.storageLocationId, householdId: input.householdId)
        guard location != nil else {
            throw InventoryDomainError.invalidLocationID
        }
    }

    func resolveIdempotentResult(_ input: AddInventoryItemInput) async throws -> AddInventoryItemOutput? {
        guard let requestID = input.idempotencyRequestId else {
            return nil
        }
        guard let metadata = try await syncStateStore.metadata(
            forRequestId: requestID,
            householdId: input.householdId,
            operation: .add
        ) else {
            return nil
        }
        guard let existing = try await inventoryRepository.findById(metadata.itemId, householdId: input.householdId) else {
            return nil
        }
        return AddInventoryItemOutput(
            itemId: existing.id,
            action: metadata.addAction ?? .created,
            item: existing,
            syncState: metadata.state
        )
    }
}

