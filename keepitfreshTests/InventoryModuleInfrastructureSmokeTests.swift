//
//  InventoryModuleInfrastructureSmokeTests.swift
//  keepitfreshTests
//
//  Created by musadhikh on 1/3/26.
//  Summary: App-layer smoke tests for InventoryModule composition and remote adapter boundaries.
//

import Factory
import Foundation
import InventoryData
import InventoryModule
import Testing
@testable import keepitfresh

@Suite("InventoryModule infrastructure smoke")
struct InventoryModuleInfrastructureSmokeTests {
    @Test("Firestore gateway uses household-scoped collection path")
    func firestoreGatewayPathUsesHouseScope() {
        let path = FirestoreInventoryModuleRemoteGateway.houseItemsCollectionPath(householdId: "house-123")
        #expect(path == "Houses/house-123/Purchases")
    }

    @Test("Firestore gateway returns empty for blank household id")
    func firestoreGatewayBlankHouseholdReturnsEmpty() async throws {
        let gateway = FirestoreInventoryModuleRemoteGateway()
        let items = try await gateway.fetchActiveItems(householdId: "   ")
        #expect(items.isEmpty)
    }

    @Test("Firestore gateway upsert no-op for empty payload")
    func firestoreGatewayEmptyUpsertDoesNotThrow() async throws {
        let gateway = FirestoreInventoryModuleRemoteGateway()
        try await gateway.upsert([])
    }

    @Test("DI resolves InventoryModule remote gateway and service")
    func inventoryModuleDIResolvesExpectedTypes() {
        let container = Container.shared

        let gateway = container.inventoryModuleRemoteGateway()
        let service = container.inventoryModuleService()
        let retryPolicy = container.inventoryModuleSyncRetryPolicy()
        let observability = container.inventoryModuleSyncObservability()
        let syncUseCase = container.inventoryModuleSyncPendingUseCase()

        #expect(gateway is FirestoreInventoryModuleRemoteGateway)
        #expect(service is AppInventoryModuleService)
        #expect(retryPolicy is InventoryModuleTypes.DefaultInventorySyncRetryPolicy)
        #expect(observability is AppInventorySyncObservability)
        #expect(syncUseCase is DefaultSyncPendingInventoryUseCase)
    }

    @Test("InventoryModule service invocation smoke throws on invalid household id")
    func inventoryModuleServiceInvocationSmoke() async throws {
        let service = Container.shared.inventoryModuleService()
        do {
            _ = try await service.getExpiredItems(
                InventoryModuleTypes.GetExpiredItemsInput(
                    householdId: "",
                    today: Date(),
                    timeZone: TimeZone(identifier: "Asia/Singapore") ?? .current
                )
            )
            #expect(Bool(false), "Expected invalid household id validation to throw")
        } catch {
            #expect(Bool(true))
        }
    }

    @Test("Sync observability sink records sync events")
    func syncObservabilityRecordsEvents() async throws {
        let now = Date(timeIntervalSince1970: 1_740_756_000)
        let item = InventoryModuleTypes.InventoryItem(
            id: "sync-observe-1",
            householdId: "house-1",
            productRef: InventoryModuleTypes.ProductRef(productId: "prod-1"),
            quantity: InventoryModuleTypes.Quantity(value: 1, unit: .piece),
            status: .active,
            storageLocationId: "loc-a",
            createdAt: now,
            updatedAt: now
        )

        let repository = InMemoryInventoryRepository(seed: [item])
        let remote = InMemoryInventoryRemoteGateway(seed: [item])
        let syncStore = InMemoryInventorySyncStateStore(
            seed: [
                InventoryModuleTypes.InventorySyncMetadata(
                    itemId: item.id,
                    householdId: item.householdId,
                    operation: .update,
                    state: .pending,
                    retryCount: 0,
                    lastError: nil,
                    lastAttemptAt: now,
                    lastSyncedAt: nil,
                    idempotencyRequestId: "obs-req",
                    addAction: nil
                )
            ]
        )
        let connectivity = AssumeOnlineConnectivityProvider()
        let observability = AppInventorySyncObservability()
        let useCase = DefaultSyncPendingInventoryUseCase(
            inventoryRepository: repository,
            remoteGateway: remote,
            syncStateStore: syncStore,
            connectivity: connectivity,
            clock: InventoryModuleTypes.SystemClock(),
            retryPolicy: InventoryModuleTypes.DefaultInventorySyncRetryPolicy(),
            observability: observability
        )

        let output = try await useCase.execute(
            InventoryModuleTypes.SyncPendingInventoryInput(householdId: "house-1")
        )
        let events = await observability.snapshotRecentEvents()

        #expect(output.syncedCount == 1)
        #expect(events.contains(where: { event in
            if case .started(let householdId) = event {
                return householdId == "house-1"
            }
            return false
        }))
        #expect(events.contains(where: { event in
            if case .itemSynced(let itemId, _) = event {
                return itemId == "sync-observe-1"
            }
            return false
        }))
    }
}
