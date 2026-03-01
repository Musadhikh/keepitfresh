//
//  GetExpiredItemsUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for fetching household expired inventory items.
//

import Foundation
import InventoryDomain

public struct GetExpiredItemsInput: Sendable, Equatable {
    public var householdId: String
    public var today: Date
    public var timeZone: TimeZone

    public init(householdId: String, today: Date, timeZone: TimeZone) {
        self.householdId = householdId
        self.today = today
        self.timeZone = timeZone
    }
}

public protocol GetExpiredItemsUseCase: Sendable {
    func execute(_ input: GetExpiredItemsInput) async throws -> [InventoryItem]
}

