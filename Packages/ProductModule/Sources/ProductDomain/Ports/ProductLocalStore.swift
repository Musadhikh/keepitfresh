//
//  ProductLocalStore.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares storage-agnostic local product persistence contract.
//

import Foundation

public protocol ProductLocalStore: Sendable {
    func get(productId: String) async throws -> Product?
    func getByBarcode(_ barcode: String) async throws -> Product?
    func getMany(productIDs: [String]) async throws -> [Product]
    func query(_ query: ProductQuery) async throws -> ProductPage

    func upsert(_ products: [Product], syncState: ProductSyncState) async throws
    func delete(productIDs: [String]) async throws
}
