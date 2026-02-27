//
//  ProductModuleServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares the application-facing product service API for app integration.
//

import Foundation
import ProductDomain

public protocol ProductModuleServicing: Sendable {
    func retrieveProduct(by lookup: ProductLookup) async throws -> Product?
    func retrieveProducts(query: ProductQuery) async throws -> ProductPage
    func addProducts(_ products: [Product]) async throws -> AddProductsResult
    func updateProducts(_ products: [Product]) async throws -> UpdateProductsResult
    func syncPending(limit: Int?) async throws -> SyncPendingResult
}

public struct AddProductsResult: Sendable, Equatable {
    public var productIDs: [String]
    public var syncedCount: Int
    public var pendingCount: Int

    public init(productIDs: [String], syncedCount: Int, pendingCount: Int) {
        self.productIDs = productIDs
        self.syncedCount = syncedCount
        self.pendingCount = pendingCount
    }
}

public struct UpdateProductsResult: Sendable, Equatable {
    public var productIDs: [String]
    public var syncedCount: Int
    public var pendingCount: Int

    public init(productIDs: [String], syncedCount: Int, pendingCount: Int) {
        self.productIDs = productIDs
        self.syncedCount = syncedCount
        self.pendingCount = pendingCount
    }
}

public struct SyncPendingResult: Sendable, Equatable {
    public var attemptedCount: Int
    public var syncedCount: Int
    public var failedCount: Int

    public init(attemptedCount: Int, syncedCount: Int, failedCount: Int) {
        self.attemptedCount = attemptedCount
        self.syncedCount = syncedCount
        self.failedCount = failedCount
    }
}
