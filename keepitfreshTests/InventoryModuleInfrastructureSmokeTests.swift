//
//  InventoryModuleInfrastructureSmokeTests.swift
//  keepitfreshTests
//
//  Created by musadhikh on 1/3/26.
//  Summary: App-layer smoke tests for InventoryModule composition and remote adapter boundaries.
//

import Factory
import Foundation
import InventoryModule
import Testing
@testable import keepitfresh

@Suite("InventoryModule infrastructure smoke")
struct InventoryModuleInfrastructureSmokeTests {
    @Test("Firestore gateway uses household-scoped collection path")
    func firestoreGatewayPathUsesHouseScope() {
        let path = FirestoreInventoryModuleRemoteGateway.houseItemsCollectionPath(householdId: "house-123")
        #expect(path == "Houses/house-123/Items")
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

        #expect(gateway is FirestoreInventoryModuleRemoteGateway)
        #expect(service is AppInventoryModuleService)
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
}
