//
//  CatalogProductRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Adapts existing catalog remote repository behavior to ProductModule remote gateway contracts.
//

import Foundation
import ProductModule

typealias PMRemoteGatewayProduct = ProductModuleTypes.Product
typealias PMRemoteGatewayProductPage = ProductModuleTypes.ProductPage
typealias PMRemoteGatewayProductQuery = ProductModuleTypes.ProductQuery

actor CatalogProductRemoteGateway: ProductRemoteGateway {
    private let catalogRepository: any CatalogRepository

    init(catalogRepository: any CatalogRepository) {
        self.catalogRepository = catalogRepository
    }

    func fetch(productId: String) async throws -> PMRemoteGatewayProduct? {
        let normalizedProductID = ProductIdentity.normalizedProductID(from: productId)
        guard normalizedProductID.isEmpty == false else {
            return nil
        }

        let barcode = Barcode(value: normalizedProductID, symbology: .unknown)
        guard let item = try await catalogRepository.findRemote(barcode: barcode) else {
            return nil
        }

        return item.asProductModuleProduct()
    }

    func fetchByBarcode(_ barcode: String) async throws -> PMRemoteGatewayProduct? {
        guard let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode) else {
            return nil
        }

        let lookupBarcode = Barcode(value: normalizedBarcode, symbology: .unknown)
        guard let item = try await catalogRepository.findRemote(barcode: lookupBarcode) else {
            return nil
        }

        return item.asProductModuleProduct()
    }

    func query(_ query: PMRemoteGatewayProductQuery) async throws -> PMRemoteGatewayProductPage {
        _ = query
        return PMRemoteGatewayProductPage(items: [])
    }

    func upsert(_ products: [PMRemoteGatewayProduct]) async throws {
        for product in products {
            guard let catalogItem = product.asCatalogItemForRepository() else { continue }
            try await catalogRepository.upsertRemote(catalogItem)
        }
    }

    func delete(productIDs: [String]) async throws {
        _ = productIDs
    }
}
