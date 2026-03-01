//
//  ProductSyncStateStore.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares sync-state persistence contract for product offline-first operations.
//

import Foundation

public protocol ProductSyncStateStore: Sendable {
    func fetchMetadata(productIDs: [String]) async throws -> [ProductSyncMetadata]
    func upsertMetadata(_ metadata: [ProductSyncMetadata]) async throws
    func listPendingProductIDs(limit: Int?) async throws -> [String]
}
