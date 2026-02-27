//
//  RealmCatalogRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Realm-backed local catalog repository with optional in-memory remote simulation.
//

import Foundation
import RealmDatabaseModule

actor RealmCatalogRepository: CatalogRepository {
    private let localRepository: RealmCodableRepository<ProductCatalogItem>
    private var remoteItemsByBarcode: [String: ProductCatalogItem]
    private var remoteAvailable: Bool

    init(
        configuration: RealmStoreConfiguration = .default,
        remoteItems: [ProductCatalogItem] = [],
        remoteAvailable: Bool = false
    ) {
        self.localRepository = RealmCodableRepository(
            namespace: RealmCatalogRepositoryNamespace.items,
            configuration: configuration,
            keyForModel: { item in
                RealmCatalogRepository.localKey(forBarcode: item.barcode.value)
            }
        )
        self.remoteItemsByBarcode = Dictionary(
            uniqueKeysWithValues: remoteItems.map {
                (RealmCatalogRepository.localKey(forBarcode: $0.barcode.value), $0)
            }
        )
        self.remoteAvailable = remoteAvailable
    }

    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem? {
        let key = Self.localKey(forBarcode: barcode.value)
        guard key.isNotEmpty else { return nil }
        return try await localRepository.fetch(primaryKey: key)
    }

    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem? {
        guard remoteAvailable else { return nil }
        return remoteItemsByBarcode[Self.localKey(forBarcode: barcode.value)]
    }

    func fetchAllLocal() async throws -> [ProductCatalogItem] {
        try await localRepository.fetchAll()
    }

    func cacheLocal(_ item: ProductCatalogItem) async throws {
        try await localRepository.upsert(item)
    }

    func upsertRemote(_ item: ProductCatalogItem) async throws {
        guard remoteAvailable else {
            throw CatalogRepositoryError.remoteUnavailable
        }
        remoteItemsByBarcode[Self.localKey(forBarcode: item.barcode.value)] = item
    }

    func setRemoteAvailable(_ isAvailable: Bool) {
        remoteAvailable = isAvailable
    }

    func seedRemote(_ item: ProductCatalogItem) {
        remoteItemsByBarcode[Self.localKey(forBarcode: item.barcode.value)] = item
    }
}

private enum RealmCatalogRepositoryNamespace {
    static let items = "add_product_catalog_items"
}

private extension RealmCatalogRepository {
    static func localKey(forBarcode barcode: String) -> String {
        barcode.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
