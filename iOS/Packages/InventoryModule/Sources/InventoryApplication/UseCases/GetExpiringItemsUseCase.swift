//
//  GetExpiringItemsUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for fetching items expiring within a time window.
//

import Foundation
import InventoryDomain

public struct GetExpiringItemsInput: Sendable, Equatable {
    public var householdId: String
    public var today: Date
    public var windowDays: Int
    public var timeZone: TimeZone

    public init(householdId: String, today: Date, windowDays: Int, timeZone: TimeZone) {
        self.householdId = householdId
        self.today = today
        self.windowDays = windowDays
        self.timeZone = timeZone
    }
}

public protocol GetExpiringItemsUseCase: Sendable {
    func execute(_ input: GetExpiringItemsInput) async throws -> [InventoryItem]
}

