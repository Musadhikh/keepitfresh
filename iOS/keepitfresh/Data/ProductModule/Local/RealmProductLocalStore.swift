//
//  RealmProductLocalStore.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Persists ProductModule products in Realm and supports local query/filter/sort pagination.
//

import Foundation
import ProductModule
import RealmDatabaseModule

typealias PMLocalStoreProduct = ProductModuleTypes.Product
typealias PMLocalStoreProductFilter = ProductModuleTypes.ProductFilter
typealias PMLocalStoreProductPage = ProductModuleTypes.ProductPage
typealias PMLocalStoreProductQuery = ProductModuleTypes.ProductQuery
typealias PMLocalStoreProductSort = ProductModuleTypes.ProductSort
typealias PMLocalStoreProductSyncState = ProductModuleTypes.ProductSyncState
typealias PMLocalStorePageCursor = ProductModuleTypes.PageCursor
typealias PMLocalStoreSortOrder = ProductModuleTypes.SortOrder

private enum ProductModuleRealmNamespace {
    static let products = "product_module_products"
}

actor RealmProductLocalStore: ProductLocalStore {
    private let repository: RealmCodableRepository<PMLocalStoreProduct>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: ProductModuleRealmNamespace.products,
            configuration: configuration,
            keyForModel: { $0.productId }
        )
    }

    func get(productId: String) async throws -> PMLocalStoreProduct? {
        let normalizedProductID = ProductIdentity.normalizedProductID(from: productId)
        guard normalizedProductID.isEmpty == false else {
            return nil
        }
        return try await repository.fetch(primaryKey: normalizedProductID)
    }

    func getByBarcode(_ barcode: String) async throws -> PMLocalStoreProduct? {
        guard let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode) else {
            return nil
        }

        let allProducts = try await repository.fetchAll()
        return allProducts.first { product in
            ProductIdentity.normalizeBarcode(product.barcode?.value) == normalizedBarcode
        }
    }

    func getMany(productIDs: [String]) async throws -> [PMLocalStoreProduct] {
        guard productIDs.isEmpty == false else {
            return []
        }

        var products: [PMLocalStoreProduct] = []
        products.reserveCapacity(productIDs.count)

        for productID in productIDs {
            guard let product = try await get(productId: productID) else { continue }
            products.append(product)
        }

        return products
    }

    func query(_ query: PMLocalStoreProductQuery) async throws -> PMLocalStoreProductPage {
        let allProducts = try await repository.fetchAll()
        let filtered = applyFilters(query.filters, to: allProducts)
        let sorted = sortProducts(filtered, by: query.sort)

        let totalCount = sorted.count
        let limit = max(1, query.page.limit)
        let offset = max(query.page.cursor.flatMap { Int($0.value) } ?? 0, 0)

        guard offset < totalCount else {
            return PMLocalStoreProductPage(items: [], nextCursor: nil, totalCount: totalCount)
        }

        let endIndex = min(offset + limit, totalCount)
        let pageItems = Array(sorted[offset..<endIndex])
        let nextCursor: PMLocalStorePageCursor? = endIndex < totalCount ? PMLocalStorePageCursor(value: String(endIndex)) : nil

        return PMLocalStoreProductPage(items: pageItems, nextCursor: nextCursor, totalCount: totalCount)
    }

    func upsert(_ products: [PMLocalStoreProduct], syncState _: PMLocalStoreProductSyncState) async throws {
        for product in products {
            try await repository.upsert(product)
        }
    }

    func delete(productIDs: [String]) async throws {
        for productID in productIDs {
            let normalizedProductID = ProductIdentity.normalizedProductID(from: productID)
            guard normalizedProductID.isEmpty == false else { continue }
            try await repository.delete(primaryKey: normalizedProductID)
        }
    }
}

private extension RealmProductLocalStore {
    func applyFilters(_ filters: [PMLocalStoreProductFilter], to products: [PMLocalStoreProduct]) -> [PMLocalStoreProduct] {
        filters.reduce(products) { partialResult, filter in
            partialResult.filter { matches(product: $0, filter: filter) }
        }
    }

    func matches(product: PMLocalStoreProduct, filter: PMLocalStoreProductFilter) -> Bool {
        switch filter {
        case .status(let status):
            return product.status == status

        case .category(let category):
            return product.category?.main == category

        case .brand(let brand):
            return normalizedText(product.brand).localizedCaseInsensitiveCompare(normalizedText(brand)) == .orderedSame

        case .hasBarcode(let hasBarcode):
            return (product.barcode != nil) == hasBarcode

        case .textSearch(let text):
            let normalizedQuery = normalizedText(text)
            guard normalizedQuery.isEmpty == false else { return true }

            return searchableFields(for: product).contains { fieldValue in
                fieldValue.localizedStandardContains(normalizedQuery)
            }

        case .source(let source):
            return product.source == source
        }
    }

    func searchableFields(for product: PMLocalStoreProduct) -> [String] {
        [
            product.productId,
            product.barcode?.value,
            product.title,
            product.brand,
            product.shortDescription,
            product.category?.sub
        ]
        .compactMap { $0 }
        .map(normalizedText)
        .filter { $0.isEmpty == false }
    }

    func sortProducts(_ products: [PMLocalStoreProduct], by sort: PMLocalStoreProductSort) -> [PMLocalStoreProduct] {
        products.sorted { lhs, rhs in
            switch sort {
            case .updatedAt(let order):
                compareDates(lhs.updatedAt, rhs.updatedAt, order: order, lhsProductID: lhs.productId, rhsProductID: rhs.productId)

            case .createdAt(let order):
                compareDates(lhs.createdAt, rhs.createdAt, order: order, lhsProductID: lhs.productId, rhsProductID: rhs.productId)

            case .title(let order):
                compareText(lhs.title, rhs.title, order: order, lhsProductID: lhs.productId, rhsProductID: rhs.productId)

            case .brand(let order):
                compareText(lhs.brand, rhs.brand, order: order, lhsProductID: lhs.productId, rhsProductID: rhs.productId)
            }
        }
    }

    func compareDates(
        _ lhs: Date,
        _ rhs: Date,
        order: PMLocalStoreSortOrder,
        lhsProductID: String,
        rhsProductID: String
    ) -> Bool {
        guard lhs != rhs else {
            return lhsProductID < rhsProductID
        }

        switch order {
        case .ascending:
            return lhs < rhs
        case .descending:
            return lhs > rhs
        }
    }

    func compareText(
        _ lhs: String?,
        _ rhs: String?,
        order: PMLocalStoreSortOrder,
        lhsProductID: String,
        rhsProductID: String
    ) -> Bool {
        let lhsValue = normalizedText(lhs)
        let rhsValue = normalizedText(rhs)
        let comparison = lhsValue.localizedCaseInsensitiveCompare(rhsValue)

        if comparison == .orderedSame {
            return lhsProductID < rhsProductID
        }

        switch order {
        case .ascending:
            return comparison == .orderedAscending
        case .descending:
            return comparison == .orderedDescending
        }
    }

    func normalizedText(_ value: String?) -> String {
        (value ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
