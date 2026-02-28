//
//  ConsumeInventoryUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares FEFO-based inventory consumption use-case contracts.
//

import Foundation
import InventoryDomain

public enum ConsumeInventoryTarget: Sendable, Equatable {
    case inventoryItemId(String)
    case productId(String, householdId: String)
}

public struct ConsumedBatchResult: Sendable, Equatable {
    public var inventoryItemId: String
    public var consumedQuantity: Quantity
    public var remainingQuantity: Quantity

    public init(inventoryItemId: String, consumedQuantity: Quantity, remainingQuantity: Quantity) {
        self.inventoryItemId = inventoryItemId
        self.consumedQuantity = consumedQuantity
        self.remainingQuantity = remainingQuantity
    }
}

public struct ConsumeInventoryInput: Sendable, Equatable {
    public var target: ConsumeInventoryTarget
    public var amount: Quantity
    public var idempotencyRequestId: String?

    public init(target: ConsumeInventoryTarget, amount: Quantity, idempotencyRequestId: String? = nil) {
        self.target = target
        self.amount = amount
        self.idempotencyRequestId = idempotencyRequestId
    }
}

public struct ConsumeInventoryOutput: Sendable, Equatable {
    public var consumed: [ConsumedBatchResult]
    public var remainingRequestedAmount: Quantity

    public init(consumed: [ConsumedBatchResult], remainingRequestedAmount: Quantity) {
        self.consumed = consumed
        self.remainingRequestedAmount = remainingRequestedAmount
    }
}

public protocol ConsumeInventoryUseCase: Sendable {
    func execute(_ input: ConsumeInventoryInput) async throws -> ConsumeInventoryOutput
}

