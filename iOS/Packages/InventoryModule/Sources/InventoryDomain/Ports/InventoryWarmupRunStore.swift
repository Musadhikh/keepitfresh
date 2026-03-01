//
//  InventoryWarmupRunStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Tracks one-time warm-up execution keys per launch and household.
//

import Foundation

public protocol InventoryWarmupRunStore: Sendable {
    func hasRun(launchId: String, householdId: String, windowDays: Int) async throws -> Bool
    func markRun(launchId: String, householdId: String, windowDays: Int) async throws
}

