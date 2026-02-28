//
//  DefaultGetInventorySummaryByProductUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements product-level inventory summary retrieval.
//

import Foundation
import InventoryDomain

public actor DefaultGetInventorySummaryByProductUseCase: GetInventorySummaryByProductUseCase {
    private let inventoryRepository: any InventoryRepository

    public init(inventoryRepository: any InventoryRepository) {
        self.inventoryRepository = inventoryRepository
    }

    public func execute(_ input: GetInventorySummaryByProductInput) async throws -> InventoryProductSummary {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.productId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidProductID
        }
        return try await inventoryRepository.summarizeByProduct(
            productId: input.productId,
            householdId: input.householdId
        )
    }
}

