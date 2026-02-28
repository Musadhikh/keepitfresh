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

private func makeItem(
    id: String,
    householdId: String,
    productId: String,
    expiryOffsetDays: Int,
    quantity: Double
) -> InventoryItem {
    let now = Date(timeIntervalSince1970: 1_740_756_000)
    let expiry = Calendar(identifier: .gregorian).date(byAdding: .day, value: expiryOffsetDays, to: now)
    return InventoryItem(
        id: id,
        householdId: householdId,
        productRef: ProductRef(productId: productId),
        quantity: Quantity(value: quantity, unit: .piece),
        status: .active,
        storageLocationId: "loc-a",
        expiryInfo: InventoryDateInfo(kind: .expiry, rawText: "\(expiryOffsetDays)d", confidence: 1.0, isoDate: expiry),
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
