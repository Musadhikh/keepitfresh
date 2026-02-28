//
//  InMemoryInventoryWarmupRunStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides actor-backed one-time-per-launch warm-up tracking for tests.
//

import Foundation
import InventoryDomain

public actor InMemoryInventoryWarmupRunStore: InventoryWarmupRunStore {
    private var runKeys: Set<String> = []

    public init() {}

    public func hasRun(launchId: String, householdId: String, windowDays: Int) async throws -> Bool {
        runKeys.contains(Self.makeKey(launchId: launchId, householdId: householdId, windowDays: windowDays))
    }

    public func markRun(launchId: String, householdId: String, windowDays: Int) async throws {
        runKeys.insert(Self.makeKey(launchId: launchId, householdId: householdId, windowDays: windowDays))
    }
}

private extension InMemoryInventoryWarmupRunStore {
    static func makeKey(launchId: String, householdId: String, windowDays: Int) -> String {
        "\(launchId)|\(householdId)|\(windowDays)"
    }
}

