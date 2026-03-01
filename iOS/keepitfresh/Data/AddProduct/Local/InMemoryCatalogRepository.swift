//
//  InMemoryCatalogRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: In-memory catalog repository for local cache + optional remote simulation.
//

import Foundation

actor InMemoryCatalogRepository: CatalogRepository {
    private var localItemsByBarcode: [String: ProductCatalogItem]
    private var remoteItemsByBarcode: [String: ProductCatalogItem]
    private var remoteAvailable: Bool

    init(
        localItems: [ProductCatalogItem] = [],
        remoteItems: [ProductCatalogItem] = [],
        remoteAvailable: Bool = false
    ) {
        self.localItemsByBarcode = Dictionary(uniqueKeysWithValues: localItems.map { ($0.barcode.value, $0) })
        self.remoteItemsByBarcode = Dictionary(uniqueKeysWithValues: remoteItems.map { ($0.barcode.value, $0) })
        self.remoteAvailable = remoteAvailable
    }

    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem? {
        localItemsByBarcode[barcode.value]
    }

    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem? {
        guard remoteAvailable else { return nil }
        return remoteItemsByBarcode[barcode.value]
    }

    func fetchAllLocal() async throws -> [ProductCatalogItem] {
        Array(localItemsByBarcode.values)
    }

    func cacheLocal(_ item: ProductCatalogItem) async throws {
        localItemsByBarcode[item.barcode.value] = item
    }

    func upsertRemote(_ item: ProductCatalogItem) async throws {
        guard remoteAvailable else {
            throw CatalogRepositoryError.remoteUnavailable
        }
        remoteItemsByBarcode[item.barcode.value] = item
    }

    // MARK: Debug/Test helpers

    func setRemoteAvailable(_ isAvailable: Bool) {
        remoteAvailable = isAvailable
    }

    func seedRemote(_ item: ProductCatalogItem) {
        remoteItemsByBarcode[item.barcode.value] = item
    }
}
