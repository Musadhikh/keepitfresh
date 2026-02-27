//
//  ProductsListViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Loads and exposes local Realm catalog items for the products list screen.
//

import Factory
import Foundation
import Observation

@MainActor
@Observable
final class ProductsListViewModel {
    @ObservationIgnored
    @Injected(\.addProductCatalogRepository)
    private var catalogRepository: any CatalogRepository

    private(set) var products: [ProductCatalogItem] = []
    private(set) var isLoading = false
    private(set) var loadErrorMessage: String?

    func loadProducts() async {
        guard isLoading == false else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let localProducts = try await catalogRepository.fetchAllLocal()
            products = localProducts.sorted(by: productSortComparator)
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
}
