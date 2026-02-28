//
//  InMemoryInventoryRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides an actor-backed in-memory remote gateway for offline-first inventory sync tests.
//

import Foundation
import InventoryDomain

public actor InMemoryInventoryRemoteGateway: InventoryRemoteGateway {
    private var shouldFailUpsert = false
    private var shouldFailFetch = false
    private var remoteStorage: [String: InventoryItem] = [:]
    private(set) var upsertedBatches: [[InventoryItem]] = []
    private(set) var fetchHouseholdRequests: [String] = []

    public init(seed: [InventoryItem] = []) {
        self.remoteStorage = Dictionary(uniqueKeysWithValues: seed.map { ($0.id, $0) })
    }

    public func setShouldFailUpsert(_ value: Bool) {
        shouldFailUpsert = value
    }

    public func setShouldFailFetch(_ value: Bool) {
        shouldFailFetch = value
    }

    public func upsert(_ items: [InventoryItem]) async throws {
        if shouldFailUpsert {
            throw InMemoryInventoryRemoteGatewayError.upsertFailed
        }
        for item in items {
            remoteStorage[item.id] = item
        }
        upsertedBatches.append(items)
    }

    public func fetchActiveItems(householdId: String) async throws -> [InventoryItem] {
        if shouldFailFetch {
            throw InMemoryInventoryRemoteGatewayError.fetchFailed
        }

        fetchHouseholdRequests.append(householdId)
        return remoteStorage.values
            .filter { $0.householdId == householdId && $0.status == .active }
            .sorted { $0.createdAt < $1.createdAt }
    }

    public func upsertCallsCount() -> Int {
        upsertedBatches.count
    }

    public func fetchCallsCount() -> Int {
        fetchHouseholdRequests.count
    }
}

public enum InMemoryInventoryRemoteGatewayError: Error, Sendable, Equatable {
    case upsertFailed
    case fetchFailed
}
