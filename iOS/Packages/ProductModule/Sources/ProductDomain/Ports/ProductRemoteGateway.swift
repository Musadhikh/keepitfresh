//
//  ProductRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares storage-agnostic remote product gateway contract.
//

import Foundation

public protocol ProductRemoteGateway: Sendable {
    func fetch(productId: String) async throws -> Product?
    func fetchByBarcode(_ barcode: String) async throws -> Product?
    func query(_ query: ProductQuery) async throws -> ProductPage

    func upsert(_ products: [Product]) async throws
    func delete(productIDs: [String]) async throws
}
