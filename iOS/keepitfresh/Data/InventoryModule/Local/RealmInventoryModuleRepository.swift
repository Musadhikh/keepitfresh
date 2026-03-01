//
//  RealmInventoryModuleRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Realm-backed local repository adapter for InventoryModule inventory batch entities.
//

import Foundation
import InventoryModule
import RealmDatabaseModule

typealias IMItem = InventoryModuleTypes.InventoryItem
typealias IMMergeKey = InventoryMergeKey
typealias IMSummary = InventoryModuleTypes.InventoryProductSummary
typealias IMQuantity = Quantity
typealias IMStatus = InventoryItemStatus

private enum InventoryModuleRealmNamespace {
    static let items = "inventory_module_items"
}

actor RealmInventoryModuleRepository: InventoryModuleTypes.InventoryRepository {
    private let repository: RealmCodableRepository<IMItem>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: InventoryModuleRealmNamespace.items,
            configuration: configuration,
            keyForModel: { $0.id }
        )
    }

    func create(_ item: IMItem) async throws {
        try await repository.upsert(item)
    }

    func upsert(_ item: IMItem) async throws {
        try await repository.upsert(item)
    }

    func updateMany(_ items: [IMItem]) async throws {
        for item in items {
            try await repository.upsert(item)
        }
    }

    func hasAnyItems(householdId: String) async throws -> Bool {
        let all = try await repository.fetchAll()
        return all.contains { $0.householdId == householdId }
    }

    func findById(_ id: String, householdId: String) async throws -> IMItem? {
        guard let item = try await repository.fetch(primaryKey: id), item.householdId == householdId else {
            return nil
        }
        return item
    }

    func findMergeCandidate(_ key: IMMergeKey) async throws -> IMItem? {
        let all = try await repository.fetchAll()
        return all.first {
            $0.status == .active &&
                $0.householdId == key.householdId &&
                $0.productRef.productId == key.productId &&
                $0.expiryInfo?.isoDate == key.expiryDate &&
                $0.openedInfo?.isoDate == key.openedAt &&
                $0.storageLocationId == key.storageLocationId &&
                $0.lotOrBatchCode == key.lotOrBatchCode
        }
    }

    func fetchActiveBatches(productId: String, householdId: String) async throws -> [IMItem] {
        try await allActive(householdId: householdId)
            .filter { $0.productRef.productId == productId }
            .sorted { $0.createdAt < $1.createdAt }
    }

    func fetchActiveByHouseholdSortedByExpiry(_ householdId: String, asOf _: Date, timeZone _: TimeZone) async throws -> [IMItem] {
        try await allActive(householdId: householdId)
            .sorted(by: expirySortComparator)
    }

    func fetchExpired(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [IMItem] {
        let startOfToday = startOfDay(for: asOf, timeZone: timeZone)
        return try await fetchActiveByHouseholdSortedByExpiry(householdId, asOf: asOf, timeZone: timeZone)
            .filter { ($0.expiryInfo?.isoDate ?? .distantFuture) < startOfToday }
    }

    func fetchExpiring(_ householdId: String, asOf: Date, windowDays: Int, timeZone: TimeZone) async throws -> [IMItem] {
        let startOfToday = startOfDay(for: asOf, timeZone: timeZone)
        let end = Calendar(identifier: .gregorian).date(byAdding: .day, value: windowDays, to: startOfToday) ?? startOfToday

        return try await fetchActiveByHouseholdSortedByExpiry(householdId, asOf: asOf, timeZone: timeZone)
            .filter { item in
                guard let expiry = item.expiryInfo?.isoDate else { return false }
                return expiry >= startOfToday && expiry <= end
            }
    }

    func summarizeByProduct(productId: String, householdId: String) async throws -> IMSummary {
        let matches = try await fetchActiveBatches(productId: productId, householdId: householdId)
        let totalValue = matches.reduce(0.0) { $0 + $1.quantity.value }
        let unit = matches.first?.quantity.unit ?? .piece
        let earliest = matches.compactMap(\.expiryInfo?.isoDate).min()

        return IMSummary(
            productId: productId,
            totalQuantity: IMQuantity(value: totalValue, unit: unit),
            batchCount: matches.count,
            activeBatchCount: matches.count,
            earliestExpiry: earliest
        )
    }
}

private extension RealmInventoryModuleRepository {
    func allActive(householdId: String) async throws -> [IMItem] {
        try await repository.fetchAll()
            .filter { $0.householdId == householdId && $0.status == IMStatus.active }
    }

    func expirySortComparator(lhs: IMItem, rhs: IMItem) -> Bool {
        switch (lhs.expiryInfo?.isoDate, rhs.expiryInfo?.isoDate) {
        case let (l?, r?):
            if l != r {
                return l < r
            }
        case (_?, nil):
            return true
        case (nil, _?):
            return false
        case (nil, nil):
            break
        }
        return lhs.createdAt < rhs.createdAt
    }

    func startOfDay(for date: Date, timeZone: TimeZone) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        return calendar.startOfDay(for: date)
    }
}
