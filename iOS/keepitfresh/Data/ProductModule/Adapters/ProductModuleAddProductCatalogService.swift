//
//  ProductModuleAddProductCatalogService.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Bridges Add Product catalog operations to ProductModule while keeping Add Product flow protocol-driven.
//

import Foundation
import enum ProductModule.ProductIdentity
import enum ProductModule.ProductLookup
import protocol ProductModule.ProductLocalStore
import protocol ProductModule.ProductModuleServicing

actor ProductModuleAddProductCatalogService: AddProductCatalogServicing {
    private let productModuleService: any ProductModuleServicing
    private let localStore: any ProductLocalStore

    init(
        productModuleService: any ProductModuleServicing,
        localStore: any ProductLocalStore
    ) {
        self.productModuleService = productModuleService
        self.localStore = localStore
    }

    func retrieveLocalCatalog(byBarcode barcode: Barcode) async throws -> ProductCatalogItem? {
        guard let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode.value) else {
            return nil
        }

        let localProduct = try await localStore.getByBarcode(normalizedBarcode)
        return localProduct?.asCatalogItemForRepository()
    }

    func retrieveLocalCatalog(productId: String) async throws -> ProductCatalogItem? {
        let normalizedProductID = ProductIdentity.normalizedProductID(from: productId)
        guard normalizedProductID.isEmpty == false else {
            return nil
        }

        let localProduct = try await localStore.get(productId: normalizedProductID)
        return localProduct?.asCatalogItemForRepository()
    }

    func retrieveCatalog(byBarcode barcode: Barcode) async throws -> ProductCatalogItem? {
        guard let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode.value) else {
            return nil
        }

        let product = try await productModuleService.retrieveProduct(by: .barcode(normalizedBarcode))
        return product?.asCatalogItemForRepository()
    }

    func upsertCatalog(_ item: ProductCatalogItem) async throws {
        let product = item.asProductModuleProduct()
        _ = try await productModuleService.addProducts([product])
    }
}
