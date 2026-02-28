//
//  GetInventorySummaryByProductUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for product-level inventory aggregate summaries.
//

import Foundation
import InventoryDomain

public struct GetInventorySummaryByProductInput: Sendable, Equatable {
    public var householdId: String
    public var productId: String

    public init(householdId: String, productId: String) {
        self.householdId = householdId
        self.productId = productId
    }
}

public protocol GetInventorySummaryByProductUseCase: Sendable {
    func execute(_ input: GetInventorySummaryByProductInput) async throws -> InventoryProductSummary
}

