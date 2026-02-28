//
//  WarmExpiringInventoryWindowUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares use-case contract for one-time-per-launch expiring inventory warm-up.
//

import Foundation
import InventoryDomain

public struct WarmExpiringInventoryWindowInput: Sendable, Equatable {
    public var householdId: String
    public var today: Date
    public var windowDays: Int
    public var timeZone: TimeZone
    public var launchId: String

    public init(householdId: String, today: Date, windowDays: Int, timeZone: TimeZone, launchId: String) {
        self.householdId = householdId
        self.today = today
        self.windowDays = windowDays
        self.timeZone = timeZone
        self.launchId = launchId
    }
}

public struct WarmExpiringInventoryWindowOutput: Sendable, Equatable {
    public var didRun: Bool
    public var refreshedCount: Int
    public var expiringCount: Int

    public init(didRun: Bool, refreshedCount: Int, expiringCount: Int) {
        self.didRun = didRun
        self.refreshedCount = refreshedCount
        self.expiringCount = expiringCount
    }
}

public protocol WarmExpiringInventoryWindowUseCase: Sendable {
    func execute(_ input: WarmExpiringInventoryWindowInput) async throws -> WarmExpiringInventoryWindowOutput
}

