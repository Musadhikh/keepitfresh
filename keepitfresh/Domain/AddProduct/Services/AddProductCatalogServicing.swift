//
//  AddProductCatalogServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines Add Product catalog operations used by flow orchestration independent of concrete data modules.
//

import Foundation

protocol AddProductCatalogServicing: Sendable {
    func retrieveLocalCatalog(byBarcode barcode: Barcode) async throws -> ProductCatalogItem?
    func retrieveLocalCatalog(productId: String) async throws -> ProductCatalogItem?
    func retrieveCatalog(byBarcode barcode: Barcode) async throws -> ProductCatalogItem?
    func upsertCatalog(_ item: ProductCatalogItem) async throws
}
