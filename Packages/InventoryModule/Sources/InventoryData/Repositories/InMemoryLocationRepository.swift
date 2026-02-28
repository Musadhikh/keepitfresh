//
//  InMemoryLocationRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides an actor-backed in-memory location repository for tests and scaffolding.
//

import Foundation
import InventoryDomain

public actor InMemoryLocationRepository: LocationRepository {
    private var storage: [String: StorageLocation] = [:]

    public init(seed: [StorageLocation] = []) {
        self.storage = Dictionary(uniqueKeysWithValues: seed.map { ($0.id, $0) })
    }

    public func fetchAll(householdId: String) async throws -> [StorageLocation] {
        storage.values
            .filter { $0.householdId == householdId }
            .sorted { $0.name < $1.name }
    }

    public func findById(_ id: String, householdId: String) async throws -> StorageLocation? {
        guard let location = storage[id], location.householdId == householdId else { return nil }
        return location
    }

    public func upsert(_ location: StorageLocation) async throws {
        storage[location.id] = location
    }
}

