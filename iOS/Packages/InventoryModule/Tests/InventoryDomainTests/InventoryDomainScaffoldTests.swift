//
//  InventoryDomainScaffoldTests.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Verifies baseline domain models compile and preserve expected values.
//

import Foundation
import Testing
@testable import InventoryDomain

struct InventoryDomainScaffoldTests {
    @Test
    func inventoryItemRetainsCoreFields() async throws {
        let now = Date()
        let item = InventoryItem(
            id: "inv-1",
            householdId: "house-1",
            productRef: ProductRef(productId: "prod-1"),
            quantity: Quantity(value: 2, unit: .piece),
            status: .active,
            storageLocationId: "loc-1",
            createdAt: now,
            updatedAt: now
        )

        #expect(item.productRef.productId == "prod-1")
        #expect(item.status == .active)
    }
}

