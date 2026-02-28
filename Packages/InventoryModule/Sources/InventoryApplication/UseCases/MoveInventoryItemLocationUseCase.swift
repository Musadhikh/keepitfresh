//
//  MoveInventoryItemLocationUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contracts for moving a batch between storage locations.
//

import Foundation
import InventoryDomain

public struct MoveInventoryItemLocationInput: Sendable, Equatable {
    public var householdId: String
    public var itemId: String
    public var targetLocationId: String

    public init(householdId: String, itemId: String, targetLocationId: String) {
        self.householdId = householdId
        self.itemId = itemId
        self.targetLocationId = targetLocationId
    }
}

public struct MoveInventoryItemLocationOutput: Sendable, Equatable {
    public var item: InventoryItem

    public init(item: InventoryItem) {
        self.item = item
    }
}

public protocol MoveInventoryItemLocationUseCase: Sendable {
    func execute(_ input: MoveInventoryItemLocationInput) async throws -> MoveInventoryItemLocationOutput
}

