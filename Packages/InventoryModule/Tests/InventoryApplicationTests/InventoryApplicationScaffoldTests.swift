//
//  InventoryApplicationScaffoldTests.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Verifies offline-first add-inventory use-case behavior including merge policy and sync-state transitions.
//

import Foundation
import InventoryData
import InventoryDomain
import Testing
@testable import InventoryApplication

struct InventoryApplicationScaffoldTests {
    @Test
    func mergeExactMatchAddsQuantityToExistingBatch() async throws {
        let fixture = try await makeFixture(online: false)
        let existing = try await fixture.seedItem(expiryOffsetDays: 3, locationId: "loc-a", quantity: 2)

        let input = AddInventoryItemInput(
            householdId: fixture.householdId,
            productRef: ProductRef(productId: fixture.productId),
            quantity: Quantity(value: 5, unit: .piece),
            storageLocationId: "loc-a",
            expiryInfo: fixture.expiryInfo(daysOffset: 3)
        )

        let output = try await fixture.useCase.execute(input)

        #expect(output.action == .merged)
        #expect(output.itemId == existing.id)
        #expect(output.item.quantity.value == 7)
        #expect(output.syncState == .pending)
    }

    @Test
    func noMergeWhenLocationDiffersCreatesNewBatch() async throws {
        let fixture = try await makeFixture(online: false)
        _ = try await fixture.seedItem(expiryOffsetDays: 3, locationId: "loc-a", quantity: 2)

        let input = AddInventoryItemInput(
            householdId: fixture.householdId,
            productRef: ProductRef(productId: fixture.productId),
            quantity: Quantity(value: 1, unit: .piece),
            storageLocationId: "loc-b",
            expiryInfo: fixture.expiryInfo(daysOffset: 3)
        )

        let output = try await fixture.useCase.execute(input)
        #expect(output.action == .created)
        #expect(output.item.storageLocationId == "loc-b")
    }

    @Test
    func noMergeWhenExpiryDiffersCreatesNewBatch() async throws {
        let fixture = try await makeFixture(online: false)
        _ = try await fixture.seedItem(expiryOffsetDays: 3, locationId: "loc-a", quantity: 2)

        let input = AddInventoryItemInput(
            householdId: fixture.householdId,
            productRef: ProductRef(productId: fixture.productId),
            quantity: Quantity(value: 1, unit: .piece),
            storageLocationId: "loc-a",
            expiryInfo: fixture.expiryInfo(daysOffset: 5)
        )

        let output = try await fixture.useCase.execute(input)
        #expect(output.action == .created)
        #expect(output.itemId != "seed-item")
    }

    @Test
    func offlineWriteStoresPendingSyncState() async throws {
        let fixture = try await makeFixture(online: false)

        let output = try await fixture.useCase.execute(
            AddInventoryItemInput(
                householdId: fixture.householdId,
                productRef: ProductRef(productId: fixture.productId),
                quantity: Quantity(value: 1, unit: .piece),
                storageLocationId: "loc-a",
                idempotencyRequestId: "req-offline"
            )
        )

        let metadata = try await fixture.syncStore.metadata(
            for: output.itemId,
            householdId: fixture.householdId,
            operation: .add
        )
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .pending)
        #expect(metadata?.state == .pending)
        #expect(remoteCalls == 0)
    }

    @Test
    func onlineWriteTransitionsToSyncedState() async throws {
        let fixture = try await makeFixture(online: true)

        let output = try await fixture.useCase.execute(
            AddInventoryItemInput(
                householdId: fixture.householdId,
                productRef: ProductRef(productId: fixture.productId),
                quantity: Quantity(value: 1, unit: .piece),
                storageLocationId: "loc-a",
                idempotencyRequestId: "req-online"
            )
        )

        let metadata = try await fixture.syncStore.metadata(
            for: output.itemId,
            householdId: fixture.householdId,
            operation: .add
        )
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .synced)
        #expect(metadata?.state == .synced)
        #expect(remoteCalls == 1)
    }

    @Test
    func idempotencyRequestPreventsDuplicateAdds() async throws {
        let fixture = try await makeFixture(online: false)
        let requestId = "req-idempotent"

        let input = AddInventoryItemInput(
            householdId: fixture.householdId,
            productRef: ProductRef(productId: fixture.productId),
            quantity: Quantity(value: 2, unit: .piece),
            storageLocationId: "loc-a",
            idempotencyRequestId: requestId
        )

        let first = try await fixture.useCase.execute(input)
        let second = try await fixture.useCase.execute(input)
        let activeBatches = try await fixture.inventoryRepository.fetchActiveBatches(
            productId: fixture.productId,
            householdId: fixture.householdId
        )

        #expect(first.itemId == second.itemId)
        #expect(activeBatches.count == 1)
        #expect(activeBatches.first?.quantity.value == 2)
    }
}

struct InventoryReadOfflineFirstTests {
    @Test
    func localMissRemoteHitReturnsRemoteAndPopulatesLocalCache() async throws {
        let fixture = await makeReadFixture(
            online: true,
            localSeed: [],
            remoteSeed: [makeItem(id: "remote-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 3, quantity: 2)]
        )

        let output = try await fixture.useCase.execute(
            GetExpiringItemsInput(
                householdId: fixture.householdId,
                today: fixture.now,
                windowDays: 14,
                timeZone: fixture.timeZone
            )
        )
        let cached = try await fixture.inventoryRepository.findById("remote-1", householdId: fixture.householdId)
        let fetchCalls = await fixture.remoteGateway.fetchCallsCount()

        #expect(output.count == 1)
        #expect(output.first?.id == "remote-1")
        #expect(cached?.id == "remote-1")
        #expect(fetchCalls == 1)
    }

    @Test
    func localHitReturnsLocalSnapshotImmediately() async throws {
        let local = makeItem(id: "item-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 4, quantity: 1)
        let remote = makeItem(id: "item-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 4, quantity: 8)

        let fixture = await makeReadFixture(
            online: true,
            localSeed: [local],
            remoteSeed: [remote]
        )

        let output = try await fixture.useCase.execute(
            GetExpiringItemsInput(
                householdId: fixture.householdId,
                today: fixture.now,
                windowDays: 14,
                timeZone: fixture.timeZone
            )
        )

        #expect(output.count == 1)
        #expect(output.first?.quantity.value == 1)
    }

    @Test
    func localHitOnlineRefreshUpdatesLocalCache() async throws {
        let local = makeItem(id: "item-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 4, quantity: 1)
        let remote = makeItem(id: "item-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 4, quantity: 8)

        let fixture = await makeReadFixture(
            online: true,
            localSeed: [local],
            remoteSeed: [remote]
        )

        _ = try await fixture.useCase.execute(
            GetExpiringItemsInput(
                householdId: fixture.householdId,
                today: fixture.now,
                windowDays: 14,
                timeZone: fixture.timeZone
            )
        )

        let refreshed = try await fixture.inventoryRepository.findById("item-1", householdId: fixture.householdId)
        let fetchCalls = await fixture.remoteGateway.fetchCallsCount()

        #expect(refreshed?.quantity.value == 8)
        #expect(fetchCalls == 1)
    }

    @Test
    func offlineLocalMissReturnsEmptyWithoutRemoteFetch() async throws {
        let fixture = await makeReadFixture(
            online: false,
            localSeed: [],
            remoteSeed: [makeItem(id: "remote-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 3, quantity: 2)]
        )

        let output = try await fixture.useCase.execute(
            GetExpiringItemsInput(
                householdId: fixture.householdId,
                today: fixture.now,
                windowDays: 14,
                timeZone: fixture.timeZone
            )
        )
        let fetchCalls = await fixture.remoteGateway.fetchCallsCount()

        #expect(output.isEmpty)
        #expect(fetchCalls == 0)
    }
}

struct InventoryConsumeOfflineFirstTests {
    @Test
    func fefoConsumesEarliestExpiryFirst() async throws {
        let oldest = makeItem(id: "batch-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 3)
        let newer = makeItem(id: "batch-2", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 5, quantity: 5)
        let fixture = await makeConsumeFixture(online: false, seed: [newer, oldest])

        let output = try await fixture.useCase.execute(
            ConsumeInventoryInput(
                target: .productId("prod-1", householdId: fixture.householdId),
                amount: Quantity(value: 4, unit: .piece)
            )
        )

        #expect(output.consumed.count == 2)
        #expect(output.consumed[0].inventoryItemId == "batch-1")
        #expect(output.consumed[0].consumedQuantity.value == 3)
        #expect(output.consumed[1].inventoryItemId == "batch-2")
        #expect(output.consumed[1].consumedQuantity.value == 1)
    }

    @Test
    func fefoPlacesNilExpiryAfterDatedBatches() async throws {
        let noExpiry = makeItem(id: "batch-nil", householdId: "house-1", productId: "prod-1", expiryOffsetDays: nil, quantity: 5)
        let dated = makeItem(id: "batch-date", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 1, quantity: 2)
        let fixture = await makeConsumeFixture(online: false, seed: [noExpiry, dated])

        let output = try await fixture.useCase.execute(
            ConsumeInventoryInput(
                target: .productId("prod-1", householdId: fixture.householdId),
                amount: Quantity(value: 1, unit: .piece)
            )
        )

        #expect(output.consumed.count == 1)
        #expect(output.consumed[0].inventoryItemId == "batch-date")
    }

    @Test
    func consumingFullBatchTransitionsStatusToConsumed() async throws {
        let item = makeItem(id: "batch-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 2)
        let fixture = await makeConsumeFixture(online: false, seed: [item])

        _ = try await fixture.useCase.execute(
            ConsumeInventoryInput(
                target: .inventoryItemId("batch-1", householdId: fixture.householdId),
                amount: Quantity(value: 2, unit: .piece)
            )
        )

        let updated = try await fixture.inventoryRepository.findById("batch-1", householdId: fixture.householdId)
        #expect(updated?.quantity.value == 0)
        #expect(updated?.status == .consumed)
        #expect(updated?.consumedAt != nil)
    }

    @Test
    func offlineConsumePersistsPendingSyncWithoutRemoteCall() async throws {
        let item = makeItem(id: "batch-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 2)
        let fixture = await makeConsumeFixture(online: false, seed: [item])

        let output = try await fixture.useCase.execute(
            ConsumeInventoryInput(
                target: .inventoryItemId("batch-1", householdId: fixture.householdId),
                amount: Quantity(value: 1, unit: .piece),
                idempotencyRequestId: "consume-offline"
            )
        )

        let metadata = try await fixture.syncStore.metadata(for: "batch-1", householdId: fixture.householdId, operation: .consume)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .pending)
        #expect(metadata?.state == .pending)
        #expect(remoteCalls == 0)
    }

    @Test
    func onlineConsumeTransitionsToSyncedState() async throws {
        let item = makeItem(id: "batch-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 2)
        let fixture = await makeConsumeFixture(online: true, seed: [item])

        let output = try await fixture.useCase.execute(
            ConsumeInventoryInput(
                target: .inventoryItemId("batch-1", householdId: fixture.householdId),
                amount: Quantity(value: 1, unit: .piece),
                idempotencyRequestId: "consume-online"
            )
        )

        let metadata = try await fixture.syncStore.metadata(for: "batch-1", householdId: fixture.householdId, operation: .consume)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .synced)
        #expect(metadata?.state == .synced)
        #expect(remoteCalls == 1)
    }
}

struct InventoryMutationOfflineFirstTests {
    @Test
    func moveLocationOfflineMarksPendingAndUpdatesLocal() async throws {
        let item = makeItem(id: "move-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])

        let output = try await fixture.moveUseCase.execute(
            MoveInventoryItemLocationInput(
                householdId: fixture.householdId,
                itemId: "move-1",
                targetLocationId: "loc-b",
                idempotencyRequestId: "move-offline"
            )
        )

        let updated = try await fixture.inventoryRepository.findById("move-1", householdId: fixture.householdId)
        let metadata = try await fixture.syncStore.metadata(for: "move-1", householdId: fixture.householdId, operation: .update)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .pending)
        #expect(updated?.storageLocationId == "loc-b")
        #expect(metadata?.state == .pending)
        #expect(remoteCalls == 0)
    }

    @Test
    func moveLocationOnlineMarksSynced() async throws {
        let item = makeItem(id: "move-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: true, seed: [item])

        let output = try await fixture.moveUseCase.execute(
            MoveInventoryItemLocationInput(
                householdId: fixture.householdId,
                itemId: "move-1",
                targetLocationId: "loc-b",
                idempotencyRequestId: "move-online"
            )
        )

        let metadata = try await fixture.syncStore.metadata(for: "move-1", householdId: fixture.householdId, operation: .update)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .synced)
        #expect(metadata?.state == .synced)
        #expect(remoteCalls == 1)
    }

    @Test
    func updateDatesOfflineMarksPendingAndPersistsDates() async throws {
        let item = makeItem(id: "date-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: nil, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])

        let expiry = InventoryDateInfo(kind: .expiry, rawText: "2026-03-20", confidence: 0.9, isoDate: Date(timeIntervalSince1970: 1_742_428_800))
        let opened = InventoryDateInfo(kind: .opened, rawText: "2026-03-01", confidence: 0.8, isoDate: Date(timeIntervalSince1970: 1_740_787_200))

        let output = try await fixture.dateUseCase.execute(
            UpdateInventoryItemDatesInput(
                householdId: fixture.householdId,
                itemId: "date-1",
                expiryInfo: expiry,
                openedInfo: opened,
                idempotencyRequestId: "date-offline"
            )
        )

        let updated = try await fixture.inventoryRepository.findById("date-1", householdId: fixture.householdId)
        let metadata = try await fixture.syncStore.metadata(for: "date-1", householdId: fixture.householdId, operation: .update)

        #expect(output.syncState == .pending)
        #expect(updated?.expiryInfo == expiry)
        #expect(updated?.openedInfo == opened)
        #expect(metadata?.state == .pending)
    }

    @Test
    func updateDatesRejectsInvalidConfidence() async throws {
        let item = makeItem(id: "date-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: nil, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])
        let invalid = InventoryDateInfo(kind: .expiry, rawText: "raw", confidence: 1.2, isoDate: nil)

        await #expect(throws: InventoryDomainError.invalidDateConfidence) {
            try await fixture.dateUseCase.execute(
                UpdateInventoryItemDatesInput(
                    householdId: fixture.householdId,
                    itemId: "date-1",
                    expiryInfo: invalid,
                    openedInfo: nil
                )
            )
        }
    }

    @Test
    func moveLocationIdempotencyPreventsSecondMutation() async throws {
        let item = makeItem(id: "move-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])
        let requestId = "move-idempotent"

        _ = try await fixture.moveUseCase.execute(
            MoveInventoryItemLocationInput(
                householdId: fixture.householdId,
                itemId: "move-1",
                targetLocationId: "loc-b",
                idempotencyRequestId: requestId
            )
        )
        let second = try await fixture.moveUseCase.execute(
            MoveInventoryItemLocationInput(
                householdId: fixture.householdId,
                itemId: "move-1",
                targetLocationId: "loc-a",
                idempotencyRequestId: requestId
            )
        )

        #expect(second.item.storageLocationId == "loc-b")
    }

    @Test
    func deleteItemOfflineMarksPendingAndArchivesLocalItem() async throws {
        let item = makeItem(id: "del-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])

        let output = try await fixture.deleteUseCase.execute(
            DeleteInventoryItemInput(
                householdId: fixture.householdId,
                itemId: "del-1",
                idempotencyRequestId: "del-offline"
            )
        )

        let updated = try await fixture.inventoryRepository.findById("del-1", householdId: fixture.householdId)
        let metadata = try await fixture.syncStore.metadata(for: "del-1", householdId: fixture.householdId, operation: .delete)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .pending)
        #expect(updated?.status == .archived)
        #expect(metadata?.state == .pending)
        #expect(remoteCalls == 0)
    }

    @Test
    func deleteItemOnlineMarksSynced() async throws {
        let item = makeItem(id: "del-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: true, seed: [item])

        let output = try await fixture.deleteUseCase.execute(
            DeleteInventoryItemInput(
                householdId: fixture.householdId,
                itemId: "del-1",
                idempotencyRequestId: "del-online"
            )
        )

        let metadata = try await fixture.syncStore.metadata(for: "del-1", householdId: fixture.householdId, operation: .delete)
        let remoteCalls = await fixture.remoteGateway.upsertCallsCount()

        #expect(output.syncState == .synced)
        #expect(metadata?.state == .synced)
        #expect(remoteCalls == 1)
    }

    @Test
    func deleteItemOnlineFailureMarksFailedAndSetsRetry() async throws {
        let item = makeItem(id: "del-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: true, seed: [item])
        await fixture.remoteGateway.setShouldFailUpsert(true)

        let output = try await fixture.deleteUseCase.execute(
            DeleteInventoryItemInput(
                householdId: fixture.householdId,
                itemId: "del-1",
                idempotencyRequestId: "del-failed"
            )
        )

        let metadata = try await fixture.syncStore.metadata(for: "del-1", householdId: fixture.householdId, operation: .delete)

        #expect(output.syncState == .failed)
        #expect(metadata?.state == .failed)
        #expect(metadata?.retryCount == 1)
    }

    @Test
    func deleteItemIdempotencyPreventsSecondMutation() async throws {
        let item = makeItem(id: "del-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 1)
        let fixture = await makeMutationFixture(online: false, seed: [item])
        let requestId = "del-idempotent"

        _ = try await fixture.deleteUseCase.execute(
            DeleteInventoryItemInput(
                householdId: fixture.householdId,
                itemId: "del-1",
                idempotencyRequestId: requestId
            )
        )
        let second = try await fixture.deleteUseCase.execute(
            DeleteInventoryItemInput(
                householdId: fixture.householdId,
                itemId: "del-1",
                idempotencyRequestId: requestId
            )
        )

        #expect(second.item.status == .archived)
    }
}

struct InventorySummaryTests {
    @Test
    func summaryReflectsActiveBatchesAndEarliestExpiry() async throws {
        let a = makeItem(id: "sum-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 5, quantity: 2)
        let b = makeItem(id: "sum-2", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 2, quantity: 3)
        let fixture = await makeSummaryFixture(seed: [a, b])

        let summary = try await fixture.useCase.execute(
            GetInventorySummaryByProductInput(householdId: fixture.householdId, productId: "prod-1")
        )

        #expect(summary.batchCount == 2)
        #expect(summary.totalQuantity.value == 5)
        #expect(summary.earliestExpiry == b.expiryInfo?.isoDate)
    }
}

struct InventorySyncCoordinatorTests {
    @Test
    func syncPendingOnlineMarksMetadataAsSynced() async throws {
        let item = makeItem(id: "sync-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 3, quantity: 1)
        let fixture = await makeSyncFixture(online: true, seed: [item])
        try await fixture.syncStore.upsertMetadata([
            InventorySyncMetadata(
                itemId: "sync-1",
                householdId: fixture.householdId,
                operation: .update,
                state: .pending,
                retryCount: 0,
                lastError: nil,
                lastAttemptAt: fixture.now,
                lastSyncedAt: nil,
                idempotencyRequestId: "sync-req",
                addAction: nil
            )
        ])

        let output = try await fixture.useCase.execute(SyncPendingInventoryInput(householdId: fixture.householdId))
        let metadata = try await fixture.syncStore.metadata(for: "sync-1", householdId: fixture.householdId, operation: .update)

        #expect(output.syncedCount == 1)
        #expect(output.failedCount == 0)
        #expect(metadata?.state == .synced)
    }

    @Test
    func syncPendingRemoteFailureMarksFailedAndIncrementsRetry() async throws {
        let item = makeItem(id: "sync-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 3, quantity: 1)
        let fixture = await makeSyncFixture(online: true, seed: [item])
        await fixture.remoteGateway.setShouldFailUpsert(true)
        try await fixture.syncStore.upsertMetadata([
            InventorySyncMetadata(
                itemId: "sync-1",
                householdId: fixture.householdId,
                operation: .update,
                state: .pending,
                retryCount: 0,
                lastError: nil,
                lastAttemptAt: fixture.now,
                lastSyncedAt: nil,
                idempotencyRequestId: "sync-req",
                addAction: nil
            )
        ])

        let output = try await fixture.useCase.execute(SyncPendingInventoryInput(householdId: fixture.householdId))
        let metadata = try await fixture.syncStore.metadata(for: "sync-1", householdId: fixture.householdId, operation: .update)

        #expect(output.syncedCount == 0)
        #expect(output.failedCount == 1)
        #expect(metadata?.state == .failed)
        #expect(metadata?.retryCount == 1)
    }
}

struct InventoryWarmupTests {
    @Test
    func warmupRunsOncePerLaunchAndSkipsSecondCall() async throws {
        let now = Date(timeIntervalSince1970: 1_740_756_000)
        let remote = makeItem(id: "warm-1", householdId: "house-1", productId: "prod-1", expiryOffsetDays: 3, quantity: 1)
        let fixture = await makeWarmupFixture(online: true, localSeed: [], remoteSeed: [remote], now: now)

        let first = try await fixture.useCase.execute(
            WarmExpiringInventoryWindowInput(
                householdId: fixture.householdId,
                today: now,
                windowDays: 14,
                timeZone: fixture.timeZone,
                launchId: "launch-1"
            )
        )
        let second = try await fixture.useCase.execute(
            WarmExpiringInventoryWindowInput(
                householdId: fixture.householdId,
                today: now,
                windowDays: 14,
                timeZone: fixture.timeZone,
                launchId: "launch-1"
            )
        )
        let fetchCalls = await fixture.remoteGateway.fetchCallsCount()

        #expect(first.didRun == true)
        #expect(first.refreshedCount == 1)
        #expect(first.expiringCount == 1)
        #expect(second.didRun == false)
        #expect(fetchCalls == 1)
    }
}

private struct AddUseCaseFixture {
    let useCase: DefaultAddInventoryItemUseCase
    let inventoryRepository: InMemoryInventoryRepository
    let locationRepository: InMemoryLocationRepository
    let remoteGateway: InMemoryInventoryRemoteGateway
    let syncStore: InMemoryInventorySyncStateStore
    let householdId: String
    let productId: String
    let now: Date

    func expiryInfo(daysOffset: Int) -> InventoryDateInfo {
        InventoryDateInfo(
            kind: .expiry,
            rawText: "\(daysOffset)d",
            confidence: 1.0,
            isoDate: Calendar(identifier: .gregorian).date(byAdding: .day, value: daysOffset, to: now)
        )
    }

    func seedItem(expiryOffsetDays: Int, locationId: String, quantity: Double) async throws -> InventoryItem {
        let item = InventoryItem(
            id: "seed-item",
            householdId: householdId,
            productRef: ProductRef(productId: productId),
            quantity: Quantity(value: quantity, unit: .piece),
            status: .active,
            storageLocationId: locationId,
            expiryInfo: expiryInfo(daysOffset: expiryOffsetDays),
            createdAt: now,
            updatedAt: now
        )
        try await inventoryRepository.create(item)
        return item
    }
}

private struct ReadUseCaseFixture {
    let useCase: DefaultGetExpiringItemsUseCase
    let inventoryRepository: InMemoryInventoryRepository
    let remoteGateway: InMemoryInventoryRemoteGateway
    let householdId: String
    let now: Date
    let timeZone: TimeZone
}

private struct ConsumeUseCaseFixture {
    let useCase: DefaultConsumeInventoryUseCase
    let inventoryRepository: InMemoryInventoryRepository
    let remoteGateway: InMemoryInventoryRemoteGateway
    let syncStore: InMemoryInventorySyncStateStore
    let householdId: String
}

private struct MutationUseCaseFixture {
    let moveUseCase: DefaultMoveInventoryItemLocationUseCase
    let dateUseCase: DefaultUpdateInventoryItemDatesUseCase
    let deleteUseCase: DefaultDeleteInventoryItemUseCase
    let inventoryRepository: InMemoryInventoryRepository
    let remoteGateway: InMemoryInventoryRemoteGateway
    let syncStore: InMemoryInventorySyncStateStore
    let householdId: String
}

private struct SummaryFixture {
    let useCase: DefaultGetInventorySummaryByProductUseCase
    let householdId: String
}

private struct SyncFixture {
    let useCase: DefaultSyncPendingInventoryUseCase
    let syncStore: InMemoryInventorySyncStateStore
    let remoteGateway: InMemoryInventoryRemoteGateway
    let householdId: String
    let now: Date
}

private struct WarmupFixture {
    let useCase: DefaultWarmExpiringInventoryWindowUseCase
    let remoteGateway: InMemoryInventoryRemoteGateway
    let householdId: String
    let timeZone: TimeZone
}

private func makeFixture(online: Bool) async throws -> AddUseCaseFixture {
    let householdId = "house-1"
    let productId = "prod-1"
    let now = Date(timeIntervalSince1970: 1_740_756_000)

    let inventoryRepository = InMemoryInventoryRepository()
    let locationRepository = InMemoryLocationRepository(
        seed: [
            StorageLocation(
                id: "loc-a",
                householdId: householdId,
                name: "Fridge",
                isColdStorage: true,
                createdAt: now,
                updatedAt: now
            ),
            StorageLocation(
                id: "loc-b",
                householdId: householdId,
                name: "Pantry",
                isColdStorage: false,
                createdAt: now,
                updatedAt: now
            )
        ]
    )
    let remoteGateway = InMemoryInventoryRemoteGateway()
    let syncStore = InMemoryInventorySyncStateStore()
    let connectivity = TestConnectivityProvider(isOnline: online)
    let clock = FixedClock(now: now)

    let useCase = DefaultAddInventoryItemUseCase(
        inventoryRepository: inventoryRepository,
        locationRepository: locationRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: clock,
        idGenerator: { "new-item-\(UUID().uuidString)" }
    )

    return AddUseCaseFixture(
        useCase: useCase,
        inventoryRepository: inventoryRepository,
        locationRepository: locationRepository,
        remoteGateway: remoteGateway,
        syncStore: syncStore,
        householdId: householdId,
        productId: productId,
        now: now
    )
}

private func makeReadFixture(
    online: Bool,
    localSeed: [InventoryItem],
    remoteSeed: [InventoryItem]
) async -> ReadUseCaseFixture {
    let householdId = "house-1"
    let now = Date(timeIntervalSince1970: 1_740_756_000)
    let timeZone = TimeZone(identifier: "Asia/Singapore") ?? TimeZone(secondsFromGMT: 0)!

    let inventoryRepository = InMemoryInventoryRepository(seed: localSeed)
    let remoteGateway = InMemoryInventoryRemoteGateway(seed: remoteSeed)
    let connectivity = TestConnectivityProvider(isOnline: online)

    let useCase = DefaultGetExpiringItemsUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        connectivity: connectivity
    )

    return ReadUseCaseFixture(
        useCase: useCase,
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        householdId: householdId,
        now: now,
        timeZone: timeZone
    )
}

private func makeConsumeFixture(
    online: Bool,
    seed: [InventoryItem]
) async -> ConsumeUseCaseFixture {
    let householdId = "house-1"
    let inventoryRepository = InMemoryInventoryRepository(seed: seed)
    let remoteGateway = InMemoryInventoryRemoteGateway()
    let syncStore = InMemoryInventorySyncStateStore()
    let connectivity = TestConnectivityProvider(isOnline: online)
    let clock = FixedClock(now: Date(timeIntervalSince1970: 1_740_756_000))

    let useCase = DefaultConsumeInventoryUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: clock
    )

    return ConsumeUseCaseFixture(
        useCase: useCase,
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStore: syncStore,
        householdId: householdId
    )
}

private func makeMutationFixture(
    online: Bool,
    seed: [InventoryItem]
) async -> MutationUseCaseFixture {
    let householdId = "house-1"
    let now = Date(timeIntervalSince1970: 1_740_756_000)
    let inventoryRepository = InMemoryInventoryRepository(seed: seed)
    let locationRepository = InMemoryLocationRepository(
        seed: [
            StorageLocation(
                id: "loc-a",
                householdId: householdId,
                name: "Fridge",
                isColdStorage: true,
                createdAt: now,
                updatedAt: now
            ),
            StorageLocation(
                id: "loc-b",
                householdId: householdId,
                name: "Pantry",
                isColdStorage: false,
                createdAt: now,
                updatedAt: now
            )
        ]
    )
    let remoteGateway = InMemoryInventoryRemoteGateway()
    let syncStore = InMemoryInventorySyncStateStore()
    let connectivity = TestConnectivityProvider(isOnline: online)
    let clock = FixedClock(now: now)

    let moveUseCase = DefaultMoveInventoryItemLocationUseCase(
        inventoryRepository: inventoryRepository,
        locationRepository: locationRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: clock
    )
    let dateUseCase = DefaultUpdateInventoryItemDatesUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: clock
    )
    let deleteUseCase = DefaultDeleteInventoryItemUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: clock
    )

    return MutationUseCaseFixture(
        moveUseCase: moveUseCase,
        dateUseCase: dateUseCase,
        deleteUseCase: deleteUseCase,
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStore: syncStore,
        householdId: householdId
    )
}

private func makeSummaryFixture(seed: [InventoryItem]) async -> SummaryFixture {
    let inventoryRepository = InMemoryInventoryRepository(seed: seed)
    let useCase = DefaultGetInventorySummaryByProductUseCase(inventoryRepository: inventoryRepository)
    return SummaryFixture(useCase: useCase, householdId: "house-1")
}

private func makeSyncFixture(
    online: Bool,
    seed: [InventoryItem]
) async -> SyncFixture {
    let now = Date(timeIntervalSince1970: 1_740_756_000)
    let householdId = "house-1"
    let inventoryRepository = InMemoryInventoryRepository(seed: seed)
    let remoteGateway = InMemoryInventoryRemoteGateway()
    let syncStore = InMemoryInventorySyncStateStore()
    let connectivity = TestConnectivityProvider(isOnline: online)
    let useCase = DefaultSyncPendingInventoryUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        syncStateStore: syncStore,
        connectivity: connectivity,
        clock: FixedClock(now: now)
    )

    return SyncFixture(
        useCase: useCase,
        syncStore: syncStore,
        remoteGateway: remoteGateway,
        householdId: householdId,
        now: now
    )
}

private func makeWarmupFixture(
    online: Bool,
    localSeed: [InventoryItem],
    remoteSeed: [InventoryItem],
    now: Date
) async -> WarmupFixture {
    let householdId = "house-1"
    let inventoryRepository = InMemoryInventoryRepository(seed: localSeed)
    let remoteGateway = InMemoryInventoryRemoteGateway(seed: remoteSeed)
    let warmupStore = InMemoryInventoryWarmupRunStore()
    let connectivity = TestConnectivityProvider(isOnline: online)
    let useCase = DefaultWarmExpiringInventoryWindowUseCase(
        inventoryRepository: inventoryRepository,
        remoteGateway: remoteGateway,
        warmupRunStore: warmupStore,
        connectivity: connectivity
    )

    return WarmupFixture(
        useCase: useCase,
        remoteGateway: remoteGateway,
        householdId: householdId,
        timeZone: TimeZone(identifier: "Asia/Singapore") ?? TimeZone(secondsFromGMT: 0)!
    )
}

private func makeItem(
    id: String,
    householdId: String,
    productId: String,
    expiryOffsetDays: Int?,
    quantity: Double
) -> InventoryItem {
    let now = Date(timeIntervalSince1970: 1_740_756_000)
    let expiry = expiryOffsetDays.flatMap { Calendar(identifier: .gregorian).date(byAdding: .day, value: $0, to: now) }
    return InventoryItem(
        id: id,
        householdId: householdId,
        productRef: ProductRef(productId: productId),
        quantity: Quantity(value: quantity, unit: .piece),
        status: .active,
        storageLocationId: "loc-a",
        expiryInfo: expiry.map { InventoryDateInfo(kind: .expiry, rawText: "\(expiryOffsetDays ?? 0)d", confidence: 1.0, isoDate: $0) },
        createdAt: now,
        updatedAt: now
    )
}

private struct TestConnectivityProvider: ConnectivityProviding {
    let isOnlineValue: Bool

    init(isOnline: Bool) {
        self.isOnlineValue = isOnline
    }

    func isOnline() async -> Bool {
        isOnlineValue
    }
}

private struct FixedClock: ClockProviding {
    let fixed: Date

    init(now: Date) {
        self.fixed = now
    }

    func now() -> Date {
        fixed
    }
}
