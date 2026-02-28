//
//  InMemoryProductReadRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides an actor-backed in-memory product read repository for integration scaffolding.
//

import Foundation
import InventoryDomain

public actor InMemoryProductReadRepository: ProductReadRepository {
    private var storage: [String: ProductReadModel] = [:]

    public init(seed: [ProductReadModel] = []) {
        self.storage = Dictionary(uniqueKeysWithValues: seed.map { ($0.productId, $0) })
    }

    public func getProduct(by productId: String) async throws -> ProductReadModel? {
        storage[productId]
    }

    public func getProducts(by productIDs: [String]) async throws -> [ProductReadModel] {
        productIDs.compactMap { storage[$0] }
    }
}

