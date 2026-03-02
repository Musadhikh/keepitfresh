//
//  AddProductSearchViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: Loads, filters, and sorts product catalog records for Add Product search screen.
//

import Factory
import Foundation
import Observation
import ProductModule

@MainActor
@Observable
final class AddProductSearchViewModel {
    enum UIState: Equatable {
        case idle
        case loading
        case empty
        case content
        case error(String)
    }

    struct SearchResultRow: Identifiable, Equatable {
        let product: ProductModuleTypes.Product

        var id: String { product.productId }
        var title: String { product.title?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty ?? "Untitled Product" }
        var brand: String { product.brand?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty ?? "Unknown Brand" }
        var categoryTitle: String {
            guard let category = product.category else { return "Uncategorized" }
            if let sub = category.sub?.trimmingCharacters(in: .whitespacesAndNewlines), sub.isEmpty == false {
                return "\(category.main.rawValue.capitalized) • \(sub)"
            }
            return category.main.rawValue.capitalized
        }
    }

    @ObservationIgnored
    @Injected(\.productModuleService)
    private var productService: any ProductModuleServicing

    var searchText: String = ""
    var selectedFilter: AddProductSearchFilter = .all

    private(set) var rows: [SearchResultRow] = []
    private(set) var uiState: UIState = .idle

    func loadProducts() async {
        uiState = .loading

        do {
            var filters: [ProductFilter] = [.status(.active)]
            if let category = selectedFilter.mappedCategory {
                filters.append(.category(category))
            }

            let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedQuery.isNotEmpty {
                filters.append(.textSearch(trimmedQuery))
            }

            let query = ProductQuery(
                page: .init(limit: 120),
                sort: .title(order: .ascending),
                filters: filters
            )

            let page = try await productService.retrieveProducts(query: query)
            let mappedRows = page.items.map(SearchResultRow.init).sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

            rows = mappedRows
            uiState = mappedRows.isEmpty ? .empty : .content
        } catch {
            rows = []
            uiState = .error("Unable to load products.")
        }
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
