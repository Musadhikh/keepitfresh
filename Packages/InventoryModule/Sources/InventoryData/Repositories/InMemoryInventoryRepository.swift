//
//  InMemoryInventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides an actor-backed in-memory inventory repository for tests and scaffolding.
//

import Foundation
import InventoryDomain

public actor InMemoryInventoryRepository: InventoryRepository {
    private var storage: [String: InventoryItem] = [:]

    public init(seed: [InventoryItem] = []) {
        self.storage = Dictionary(uniqueKeysWithValues: seed.map { ($0.id, $0) })
    }

    public func create(_ item: InventoryItem) async throws {
        storage[item.id] = item
    }

    public func upsert(_ item: InventoryItem) async throws {
        storage[item.id] = item
    }

    public func updateMany(_ items: [InventoryItem]) async throws {
        for item in items {
            storage[item.id] = item
        }
    }

    public func hasAnyItems(householdId: String) async throws -> Bool {
        storage.values.contains { $0.householdId == householdId }
    }

    public func findById(_ id: String, householdId: String) async throws -> InventoryItem? {
        guard let item = storage[id], item.householdId == householdId else { return nil }
        return item
    }

    public func findMergeCandidate(_ key: InventoryMergeKey) async throws -> InventoryItem? {
        storage.values.first {
            $0.status == .active
                && $0.householdId == key.householdId
                && $0.productRef.productId == key.productId
                && $0.expiryInfo?.isoDate == key.expiryDate
                && $0.openedInfo?.isoDate == key.openedAt
                && $0.storageLocationId == key.storageLocationId
                && $0.lotOrBatchCode == key.lotOrBatchCode
        }
    }

    public func fetchActiveBatches(productId: String, householdId: String) async throws -> [InventoryItem] {
        storage.values
            .filter { $0.householdId == householdId && $0.productRef.productId == productId && $0.status == .active }
            .sorted(by: { $0.createdAt < $1.createdAt })
    }

    public func fetchActiveByHouseholdSortedByExpiry(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [InventoryItem] {
        let active = storage.values.filter { $0.householdId == householdId && $0.status == .active }
        let sorted = active.sorted { lhs, rhs in
            switch (lhs.expiryInfo?.isoDate, rhs.expiryInfo?.isoDate) {
            case let (l?, r?):
                if l != r { return l < r }
            case (_?, nil):
                return true
            case (nil, _?):
                return false
            case (nil, nil):
                break
            }
            return lhs.createdAt < rhs.createdAt
        }
        return sorted
    }

    public func fetchExpired(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [InventoryItem] {
        let calendar = Calendar(identifier: .gregorian)
        let startOfToday = calendar.startOfDay(for: asOf)
        return try await fetchActiveByHouseholdSortedByExpiry(householdId, asOf: asOf, timeZone: timeZone)
            .filter { ($0.expiryInfo?.isoDate ?? .distantFuture) < startOfToday }
    }

    public func fetchExpiring(_ householdId: String, asOf: Date, windowDays: Int, timeZone: TimeZone) async throws -> [InventoryItem] {
        let calendar = Calendar(identifier: .gregorian)
        let startOfToday = calendar.startOfDay(for: asOf)
        let end = calendar.date(byAdding: .day, value: windowDays, to: startOfToday) ?? startOfToday
        return try await fetchActiveByHouseholdSortedByExpiry(householdId, asOf: asOf, timeZone: timeZone)
            .filter { item in
                guard let expiry = item.expiryInfo?.isoDate else { return false }
                return expiry >= startOfToday && expiry <= end
            }
    }

    public func summarizeByProduct(productId: String, householdId: String) async throws -> InventoryProductSummary {
        let matches = try await fetchActiveBatches(productId: productId, householdId: householdId)
        let unit = matches.first?.quantity.unit ?? .piece
        let total = matches.reduce(0.0) { $0 + $1.quantity.value }
        let earliest = matches.compactMap(\.expiryInfo?.isoDate).min()

        return InventoryProductSummary(
            productId: productId,
            totalQuantity: Quantity(value: total, unit: unit),
            batchCount: matches.count,
            activeBatchCount: matches.count,
            earliestExpiry: earliest
        )
    }
}
