//
//  HomeViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Loads Home inventory buckets and handles row actions with undo-safe restore.
//

import Factory
import Foundation
import InventoryModule
import Observation
import ProductModule

@MainActor
@Observable
final class HomeViewModel {
    struct InventoryRowModel: Identifiable, Hashable {
        let item: InventoryModuleTypes.InventoryItem
        let title: String
        let categoryTitle: String
        let categorySymbol: String
        let expiryDateText: String
        let relativeExpiryLabel: String
        let isExpired: Bool

        var id: String { item.id }
    }

    struct UndoBanner: Identifiable, Equatable {
        let id = UUID()
        let message: String
    }

    enum UIState: Equatable {
        case loading
        case error(message: String)
        case empty
        case content(
            expired: [InventoryRowModel],
            expiringIn3Days: [InventoryRowModel],
            expiringIn7Days: [InventoryRowModel]
        )
    }
    
    private let onNext: (HomeCoordinator.HomeRoute) -> Void
    
    private static let homeLaunchWarmupID = UUID().uuidString

    @ObservationIgnored
    @Injected(\.inventoryModuleService)
    private var inventoryModuleService: any InventoryModuleTypes.InventoryModuleServicing

    @ObservationIgnored
    @Injected(\.productModuleService)
    private var productModuleService: any ProductModuleServicing

    @ObservationIgnored
    @Injected(\.inventoryUndoService)
    private var inventoryUndoService: any InventoryUndoServicing

    private(set) var expiredItems: [InventoryRowModel] = []
    private(set) var expiringIn3DaysItems: [InventoryRowModel] = []
    private(set) var expiringIn7DaysItems: [InventoryRowModel] = []
    private(set) var isLoading = false
    private(set) var loadErrorMessage: String?
    private(set) var mutatingItemIDs: Set<String> = []
    private(set) var undoBanner: UndoBanner?

    private var pendingUndoSnapshot: InventoryModuleTypes.InventoryItem?
    @ObservationIgnored
    private var undoDismissTask: Task<Void, Never>?

    init(onNext: @escaping (HomeCoordinator.HomeRoute) -> Void) {
        self.onNext = onNext
    }
    
    deinit {
        undoDismissTask?.cancel()
    }

    var hasAnyItems: Bool {
        expiredItems.isNotEmpty || expiringIn3DaysItems.isNotEmpty || expiringIn7DaysItems.isNotEmpty
    }

    var expiredCount: Int {
        expiredItems.count
    }

    var uiState: UIState {
        if isLoading && hasAnyItems == false {
            return .loading
        }
        if let loadErrorMessage {
            return .error(message: loadErrorMessage)
        }
        if hasAnyItems == false {
            return .empty
        }
        return .content(
            expired: expiredItems,
            expiringIn3Days: expiringIn3DaysItems,
            expiringIn7Days: expiringIn7DaysItems
        )
    }

    func loadInventory(householdId: String?) async {
        guard isLoading == false else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            guard let householdId, householdId.isEmpty == false else {
                expiredItems = []
                expiringIn3DaysItems = []
                expiringIn7DaysItems = []
                loadErrorMessage = nil
                return
            }

            let now = Date()
            let timeZone = TimeZone.current

            _ = try? await inventoryModuleService.warmExpiringInventoryWindow(
                InventoryModuleTypes.WarmExpiringInventoryWindowInput(
                    householdId: householdId,
                    today: now,
                    windowDays: 14,
                    timeZone: timeZone,
                    launchId: Self.homeLaunchWarmupID
                )
            )

            async let expired = inventoryModuleService.getExpiredItems(
                InventoryModuleTypes.GetExpiredItemsInput(
                    householdId: householdId,
                    today: now,
                    timeZone: timeZone
                )
            )
            async let expiringWithin7Days = inventoryModuleService.getExpiringItems(
                InventoryModuleTypes.GetExpiringItemsInput(
                    householdId: householdId,
                    today: now,
                    windowDays: 7,
                    timeZone: timeZone
                )
            )

            let (expiredResult, expiringResult) = try await (expired, expiringWithin7Days)
            let productMap = await fetchProductMap(for: Set((expiredResult + expiringResult).map(\.productRef.productId)))

            let expiredRows = expiredResult.map { makeRowModel(item: $0, productMap: productMap, referenceDate: now, isExpired: true) }
                .sorted(by: inventorySortComparator)

            let split = splitExpiringItems(expiringResult, referenceDate: now)
            let expiring3DaysRows = split.inThreeDays
                .map { makeRowModel(item: $0, productMap: productMap, referenceDate: now, isExpired: false) }
                .sorted(by: inventorySortComparator)
            let expiring7DaysRows = split.inSevenDays
                .map { makeRowModel(item: $0, productMap: productMap, referenceDate: now, isExpired: false) }
                .sorted(by: inventorySortComparator)

            expiredItems = expiredRows
            expiringIn3DaysItems = expiring3DaysRows
            expiringIn7DaysItems = expiring7DaysRows
            loadErrorMessage = nil
        } catch {
            expiredItems = []
            expiringIn3DaysItems = []
            expiringIn7DaysItems = []
            loadErrorMessage = "Unable to load inventory alerts."
        }
    }

    func discard(_ row: InventoryRowModel, householdId: String?) async -> Bool {
        guard let householdId, householdId.isEmpty == false else { return false }
        guard mutatingItemIDs.contains(row.id) == false else { return false }

        mutatingItemIDs.insert(row.id)
        defer { mutatingItemIDs.remove(row.id) }

        do {
            _ = try await inventoryModuleService.deleteInventoryItem(
                InventoryModuleTypes.DeleteInventoryItemInput(
                    householdId: householdId,
                    itemId: row.item.id,
                    idempotencyRequestId: UUID().uuidString
                )
            )
            presentUndo(message: "Item discarded", snapshot: row.item)
            await loadInventory(householdId: householdId)
            return true
        } catch {
            loadErrorMessage = "Unable to discard item."
            return false
        }
    }

    func finish(_ row: InventoryRowModel, householdId: String?) async -> Bool {
        guard let householdId, householdId.isEmpty == false else { return false }
        guard mutatingItemIDs.contains(row.id) == false else { return false }
        guard row.item.quantity.value > 0 else { return false }

        mutatingItemIDs.insert(row.id)
        defer { mutatingItemIDs.remove(row.id) }

        do {
            _ = try await inventoryModuleService.consumeInventory(
                InventoryModuleTypes.ConsumeInventoryInput(
                    target: .inventoryItemId(row.item.id, householdId: householdId),
                    amount: row.item.quantity,
                    idempotencyRequestId: UUID().uuidString
                )
            )
            presentUndo(message: "Marked as finished", snapshot: row.item)
            await loadInventory(householdId: householdId)
            return true
        } catch {
            loadErrorMessage = "Unable to finish item."
            return false
        }
    }

    func undoLastAction(householdId: String?) async -> Bool {
        guard let snapshot = pendingUndoSnapshot else { return false }
        guard let householdId, householdId == snapshot.householdId else { return false }

        clearUndoState()

        do {
            _ = try await inventoryUndoService.restore(snapshot)
            await loadInventory(householdId: householdId)
            return true
        } catch {
            loadErrorMessage = "Unable to restore previous item state."
            return false
        }
    }

    func clearUndoBanner() {
        clearUndoState()
    }
}

private extension HomeViewModel {
    typealias ProductModel = ProductModuleTypes.Product

    func fetchProductMap(for productIDs: Set<String>) async -> [String: ProductModel] {
        guard productIDs.isEmpty == false else { return [:] }
        let productService = productModuleService

        return await withTaskGroup(of: (String, ProductModel?).self, returning: [String: ProductModel].self) { group in
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

            var map: [String: ProductModel] = [:]
            for await (productID, product) in group {
                if let product {
                    map[productID] = product
                }
            }
            return map
        }
    }

    func splitExpiringItems(
        _ items: [InventoryModuleTypes.InventoryItem],
        referenceDate: Date
    ) -> (inThreeDays: [InventoryModuleTypes.InventoryItem], inSevenDays: [InventoryModuleTypes.InventoryItem]) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current

        let startOfToday = calendar.startOfDay(for: referenceDate)
        var inThreeDays: [InventoryModuleTypes.InventoryItem] = []
        var inSevenDays: [InventoryModuleTypes.InventoryItem] = []

        for item in items {
            guard let expiryDate = item.expiryInfo?.isoDate else { continue }
            let startOfExpiryDay = calendar.startOfDay(for: expiryDate)
            guard let dayOffset = calendar.dateComponents([.day], from: startOfToday, to: startOfExpiryDay).day else {
                continue
            }

            if (0 ... 3).contains(dayOffset) {
                inThreeDays.append(item)
            } else if (4 ... 7).contains(dayOffset) {
                inSevenDays.append(item)
            }
        }

        return (inThreeDays, inSevenDays)
    }

    func makeRowModel(
        item: InventoryModuleTypes.InventoryItem,
        productMap: [String: ProductModel],
        referenceDate: Date,
        isExpired: Bool
    ) -> InventoryRowModel {
        let product = productMap[item.productRef.productId]
        let title = item.productRef.snapshot?.title?.trimmedNonEmpty
            ?? product?.title?.trimmedNonEmpty
            ?? item.productRef.productId

        let categoryMain = product?.category?.main
        let categoryTitle = categoryMain.map(categoryDisplayName(for:)) ?? "Uncategorized"
        let categorySymbol = categoryMain.map(categorySymbolName(for:)) ?? "shippingbox.fill"

        let expiryDateText: String
        if let expiryDate = item.expiryInfo?.isoDate {
            expiryDateText = expiryDate.formatted(.dateTime.year().month(.abbreviated).day())
        } else {
            expiryDateText = "No expiry date"
        }

        return InventoryRowModel(
            item: item,
            title: title,
            categoryTitle: categoryTitle,
            categorySymbol: categorySymbol,
            expiryDateText: expiryDateText,
            relativeExpiryLabel: relativeExpiryText(for: item.expiryInfo?.isoDate, referenceDate: referenceDate),
            isExpired: isExpired
        )
    }

    func relativeExpiryText(for expiryDate: Date?, referenceDate: Date) -> String {
        guard let expiryDate else {
            return "No expiry date"
        }

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        let startOfToday = calendar.startOfDay(for: referenceDate)
        let startOfExpiryDay = calendar.startOfDay(for: expiryDate)

        if calendar.isDate(startOfExpiryDay, inSameDayAs: startOfToday) {
            return "Expires Today"
        }

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeValue = formatter.localizedString(for: startOfExpiryDay, relativeTo: startOfToday)

        if startOfExpiryDay < startOfToday {
            return "Expired \(relativeValue)"
        }

        return "Expires \(relativeValue)"
    }

    func inventorySortComparator(lhs: InventoryRowModel, rhs: InventoryRowModel) -> Bool {
        let lhsDate = lhs.item.expiryInfo?.isoDate ?? .distantFuture
        let rhsDate = rhs.item.expiryInfo?.isoDate ?? .distantFuture

        if lhsDate != rhsDate {
            return lhsDate < rhsDate
        }
        return lhs.id < rhs.id
    }

    func presentUndo(message: String, snapshot: InventoryModuleTypes.InventoryItem) {
        undoDismissTask?.cancel()
        pendingUndoSnapshot = snapshot

        let banner = UndoBanner(message: message)
        undoBanner = banner

        undoDismissTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(5))
            self?.expireUndoBannerIfNeeded(id: banner.id)
        }
    }

    func expireUndoBannerIfNeeded(id: UUID) {
        guard undoBanner?.id == id else { return }
        clearUndoState()
    }

    func clearUndoState() {
        undoDismissTask?.cancel()
        undoDismissTask = nil
        pendingUndoSnapshot = nil
        undoBanner = nil
    }

    func categoryDisplayName(for category: ProductModuleTypes.MainCategory) -> String {
        switch category {
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

    func categorySymbolName(for category: ProductModuleTypes.MainCategory) -> String {
        switch category {
        case .food:
            return "carton.fill"
        case .beverage:
            return "cup.and.saucer.fill"
        case .household:
            return "house.fill"
        case .personalCare:
            return "sparkles"
        case .medicine:
            return "cross.case.fill"
        case .electronics:
            return "cable.connector"
        case .pet:
            return "pawprint.fill"
        case .other:
            return "shippingbox.fill"
        }
    }
}

extension HomeViewModel {
    func navigateToProduct() {
        onNext(.productAdd)
    }
}

private extension String {
    var trimmedNonEmpty: String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}


