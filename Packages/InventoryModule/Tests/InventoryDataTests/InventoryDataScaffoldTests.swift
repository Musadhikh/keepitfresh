//
//  InventoryDataScaffoldTests.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Verifies in-memory data adapters satisfy baseline repository behavior.
//

import Foundation
import Testing
@testable import InventoryData
import InventoryDomain

struct InventoryDataScaffoldTests {
    @Test
    func inMemoryInventoryRepositoryStoresAndFindsById() async throws {
        let repository = InMemoryInventoryRepository()
        let now = Date()
        let item = InventoryItem(
            id: "inv-1",
            householdId: "house-1",
            productRef: ProductRef(productId: "prod-1"),
            quantity: Quantity(value: 3, unit: .piece),
            status: .active,
            storageLocationId: "loc-1",
            createdAt: now,
            updatedAt: now
        )

        try await repository.create(item)
        let fetched = try await repository.findById("inv-1", householdId: "house-1")
        #expect(fetched?.id == "inv-1")
    }
}
