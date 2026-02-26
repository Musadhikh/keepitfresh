//
//  CatalogRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Catalog lookup and cache contract for add-product flow.
//

import Foundation

enum CatalogRepositoryError: Error, Sendable {
    case remoteUnavailable
    case unknown
}

protocol CatalogRepository: Sendable {
    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem?
    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem?

    func cacheLocal(_ item: ProductCatalogItem) async throws
    func upsertRemote(_ item: ProductCatalogItem) async throws
}
