//
//  UpdateInventoryItemDatesUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contracts for updating batch date metadata.
//

import Foundation
import InventoryDomain

public struct UpdateInventoryItemDatesInput: Sendable, Equatable {
    public var householdId: String
    public var itemId: String
    public var expiryInfo: InventoryDateInfo?
    public var openedInfo: InventoryDateInfo?

    public init(householdId: String, itemId: String, expiryInfo: InventoryDateInfo?, openedInfo: InventoryDateInfo?) {
        self.householdId = householdId
        self.itemId = itemId
        self.expiryInfo = expiryInfo
        self.openedInfo = openedInfo
    }
}

public struct UpdateInventoryItemDatesOutput: Sendable, Equatable {
    public var item: InventoryItem

    public init(item: InventoryItem) {
        self.item = item
    }
}

public protocol UpdateInventoryItemDatesUseCase: Sendable {
    func execute(_ input: UpdateInventoryItemDatesInput) async throws -> UpdateInventoryItemDatesOutput
}

