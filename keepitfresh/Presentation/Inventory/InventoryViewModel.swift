//
//  InventoryViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Loads active household inventory and exposes paginated, sortable, filterable rows.
//

import Factory
import Foundation
import InventoryModule
import Observation
import ProductModule

@MainActor
@Observable
final class InventoryViewModel {
    enum SortOption: String, CaseIterable, Identifiable {
        case expiryAscending = "Expiry Date"
        case alphabetical = "Alphabetical"
        case newestFirst = "Recently Added"

        var id: String { rawValue }
    }

    enum ExpiryFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case withExpiry = "With Expiry"
        case withoutExpiry = "No Expiry"

        var id: String { rawValue }
    }

    struct InventoryListRow: Identifiable, Hashable {
        let item: InventoryModuleTypes.InventoryItem
        let title: String
        let categoryTitle: String
        let categoryKey: String
        let expiryText: String

        var id: String { item.id }
    }

    private static let pageSize = 50

    @ObservationIgnored
    @Injected(\.inventoryModuleInventoryRepository)
    private var inventoryRepository: any InventoryModuleTypes.InventoryRepository

    @ObservationIgnored
    @Injected(\.productModuleService)
    private var productModuleService: any ProductModuleServicing

    private(set) var rows: [InventoryListRow] = []
    private(set) var isLoading = false
    private(set) var isLoadingMore = false
    private(set) var errorMessage: String?
    private(set) var canLoadMore = false

    var selectedSort: SortOption = .expiryAscending {
        didSet { resetPagination() }
    }

    var selectedExpiryFilter: ExpiryFilter = .all {
        didSet { resetPagination() }
    }

    var selectedCategory: String = "All" {
        didSet { resetPagination() }
    }

    private(set) var categoryOptions: [String] = ["All"]

    private var allRows: [InventoryListRow] = []
    private var nextOffset = 0

    func loadInitial(householdId: String?) async {
        guard isLoading == false else { return }
        guard let householdId, householdId.isNotEmpty else {
            rows = []
            allRows = []
            categoryOptions = ["All"]
            errorMessage = nil
            canLoadMore = false
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let items = try await inventoryRepository.fetchActiveByHouseholdSortedByExpiry(
                householdId,
                asOf: Date(),
                timeZone: TimeZone.current
            )

            let productMap = await fetchProductMap(for: Set(items.map(\.productRef.productId)))
            allRows = items.map { makeRow(from: $0, productMap: productMap) }

            categoryOptions = ["All"] + Array(
                Set(allRows.map(\.categoryTitle).filter(\.isNotEmpty))
            ).sorted()

            if categoryOptions.contains(selectedCategory) == false {
                selectedCategory = "All"
            }

            errorMessage = nil
            resetPagination()
        } catch {
            rows = []
            allRows = []
            categoryOptions = ["All"]
            canLoadMore = false
            nextOffset = 0
            errorMessage = "Unable to load inventory list."
        }
    }

    func loadMoreIfNeeded(currentRow: InventoryListRow) async {
        guard canLoadMore else { return }
        guard isLoadingMore == false else { return }
        guard rows.last?.id == currentRow.id else { return }

        isLoadingMore = true
        defer { isLoadingMore = false }
        appendNextPage()
    }

    private func resetPagination() {
        rows = []
        nextOffset = 0
        appendNextPage()
    }

    private func appendNextPage() {
        let source = filteredAndSortedRows()
        guard nextOffset < source.count else {
            canLoadMore = false
            return
        }

        let end = min(nextOffset + Self.pageSize, source.count)
        rows.append(contentsOf: source[nextOffset..<end])
        nextOffset = end
        canLoadMore = nextOffset < source.count
    }

    private func filteredAndSortedRows() -> [InventoryListRow] {
        let filtered = allRows.filter { row in
            let matchesCategory = selectedCategory == "All" || row.categoryTitle == selectedCategory
            let hasExpiry = row.item.expiryInfo?.isoDate != nil

            let matchesExpiry: Bool
            switch selectedExpiryFilter {
            case .all:
                matchesExpiry = true
            case .withExpiry:
                matchesExpiry = hasExpiry
            case .withoutExpiry:
                matchesExpiry = hasExpiry == false
            }

            return matchesCategory && matchesExpiry
        }

        switch selectedSort {
        case .expiryAscending:
            return filtered.sorted { lhs, rhs in
                let lhsExpiry = lhs.item.expiryInfo?.isoDate
                let rhsExpiry = rhs.item.expiryInfo?.isoDate

                switch (lhsExpiry, rhsExpiry) {
                case let (l?, r?):
                    if l != r { return l < r }
                case (_?, nil):
                    return true
                case (nil, _?):
                    return false
                case (nil, nil):
                    break
                }

                if lhs.title.localizedCaseInsensitiveCompare(rhs.title) != .orderedSame {
                    return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
                }
                return lhs.item.id < rhs.item.id
            }

        case .alphabetical:
            return filtered.sorted { lhs, rhs in
                if lhs.title.localizedCaseInsensitiveCompare(rhs.title) != .orderedSame {
                    return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
                }
                return lhs.item.id < rhs.item.id
            }

        case .newestFirst:
            return filtered.sorted { lhs, rhs in
                if lhs.item.createdAt != rhs.item.createdAt {
                    return lhs.item.createdAt > rhs.item.createdAt
                }
                return lhs.item.id < rhs.item.id
            }
        }
    }

    private func makeRow(
        from item: InventoryModuleTypes.InventoryItem,
        productMap: [String: ProductModuleTypes.Product]
    ) -> InventoryListRow {
        let product = productMap[item.productRef.productId]
        let title = preferredTitle(for: item, product: product)

        let categoryTitle = product?.category.map(categoryLabel(for:)) ?? "Uncategorized"
        let categoryKey = product?.category?.main.rawValue ?? "uncategorized"

        let expiryText: String
        if let expiryDate = item.expiryInfo?.isoDate {
            expiryText = expiryDate.formatted(.dateTime.year().month(.abbreviated).day())
        } else {
            expiryText = "No expiry"
        }

        return InventoryListRow(
            item: item,
            title: title,
            categoryTitle: categoryTitle,
            categoryKey: categoryKey,
            expiryText: expiryText
        )
    }

    private func preferredTitle(
        for item: InventoryModuleTypes.InventoryItem,
        product: ProductModuleTypes.Product?
    ) -> String {
        if let productTitle = product?.title?.trimmingCharacters(in: .whitespacesAndNewlines), productTitle.isNotEmpty {
            return productTitle
        }
        if let snapshotTitle = item.productRef.snapshot?.title?.trimmingCharacters(in: .whitespacesAndNewlines), snapshotTitle.isNotEmpty {
            return snapshotTitle
        }
        return item.productRef.productId
    }

    private func categoryLabel(for category: ProductModuleTypes.ProductCategory) -> String {
        if let sub = category.sub?.trimmingCharacters(in: .whitespacesAndNewlines), sub.isNotEmpty {
            return "\(category.main.displayName) • \(sub)"
        }
        return category.main.displayName
    }

    private func fetchProductMap(for productIDs: Set<String>) async -> [String: ProductModuleTypes.Product] {
        guard productIDs.isNotEmpty else { return [:] }

        let productService = productModuleService
        return await withTaskGroup(of: (String, ProductModuleTypes.Product?).self, returning: [String: ProductModuleTypes.Product].self) { group in
            for productID in productIDs {
                group.addTask {
                    do {
                        let product = try await productService.retrieveProduct(by: .productId(productID))
                        return (productID, product)
                    } catch {
                        return (productID, nil)
                    }
                }
            }

            var map: [String: ProductModuleTypes.Product] = [:]
            for await (productID, product) in group {
                if let product {
                    map[productID] = product
                }
            }
            return map
        }
    }
}

private extension ProductModuleTypes.MainCategory {
    var displayName: String {
        switch self {
        case .food:
            return "Food"
        case .beverage:
            return "Beverage"
        case .household:
            return "Household"
        case .personalCare:
            return "Personal Care"
        case .medicine:
            return "Medicine"
        case .electronics:
            return "Electronics"
        case .pet:
            return "Pet"
        case .other:
            return "Other"
        }
    }
}
