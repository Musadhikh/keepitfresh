//
//  ProductsListViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Loads products through ProductModule query APIs and exposes the existing catalog row model.
//

import Factory
import Foundation
import Observation
import ProductModule

@MainActor
@Observable
final class ProductsListViewModel {
    @ObservationIgnored
    @Injected(\.productModuleService)
    private var productModuleService: any ProductModuleServicing

    private(set) var products: [ProductCatalogItem] = []
    private(set) var isLoading = false
    private(set) var loadErrorMessage: String?

    func loadProducts() async {
        guard isLoading == false else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let moduleProducts = try await fetchAllProductsFromModule()
            products = moduleProducts.compactMap { $0.asCatalogItemForRepository() }
                .sorted(by: productSortComparator)
            loadErrorMessage = nil
        } catch {
            products = []
            loadErrorMessage = "Unable to load local products."
        }
    }

    private func productSortComparator(lhs: ProductCatalogItem, rhs: ProductCatalogItem) -> Bool {
        let lhsTitle = lhs.title?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let rhsTitle = rhs.title?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if lhsTitle.localizedCaseInsensitiveCompare(rhsTitle) != .orderedSame {
            return lhsTitle.localizedCaseInsensitiveCompare(rhsTitle) == .orderedAscending
        }
        return lhs.barcode.value < rhs.barcode.value
    }

    private func fetchAllProductsFromModule() async throws -> [ProductModuleTypes.Product] {
        var aggregated: [ProductModuleTypes.Product] = []
        var cursor: ProductModuleTypes.PageCursor?

        repeat {
            let query = ProductModuleTypes.ProductQuery(
                page: ProductModuleTypes.PageRequest(limit: 200, cursor: cursor),
                sort: .title(order: .ascending),
                filters: []
            )
            let page = try await productModuleService.retrieveProducts(query: query)
            aggregated.append(contentsOf: page.items)
            cursor = page.nextCursor
        } while cursor != nil

        return aggregated
    }
}
