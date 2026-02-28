//
//  InventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares inventory data-access contracts used by application use cases.
//

import Foundation

public struct InventoryProductSummary: Sendable, Codable, Equatable, Hashable {
    public var productId: String
    public var totalQuantity: Quantity
    public var batchCount: Int
    public var activeBatchCount: Int
    public var earliestExpiry: Date?

    public init(
        productId: String,
        totalQuantity: Quantity,
        batchCount: Int,
        activeBatchCount: Int,
        earliestExpiry: Date?
    ) {
        self.productId = productId
        self.totalQuantity = totalQuantity
        self.batchCount = batchCount
        self.activeBatchCount = activeBatchCount
        self.earliestExpiry = earliestExpiry
    }
}

public protocol InventoryRepository: Sendable {
    func create(_ item: InventoryItem) async throws
    func upsert(_ item: InventoryItem) async throws
    func updateMany(_ items: [InventoryItem]) async throws
    func hasAnyItems(householdId: String) async throws -> Bool
    func findById(_ id: String, householdId: String) async throws -> InventoryItem?
    func findMergeCandidate(_ key: InventoryMergeKey) async throws -> InventoryItem?
    func fetchActiveBatches(productId: String, householdId: String) async throws -> [InventoryItem]
    func fetchActiveByHouseholdSortedByExpiry(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [InventoryItem]
    func fetchExpired(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [InventoryItem]
    func fetchExpiring(_ householdId: String, asOf: Date, windowDays: Int, timeZone: TimeZone) async throws -> [InventoryItem]
    func summarizeByProduct(productId: String, householdId: String) async throws -> InventoryProductSummary
}
