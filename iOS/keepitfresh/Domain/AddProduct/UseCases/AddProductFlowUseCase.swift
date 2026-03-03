//
//  AddProductFlowUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Actor orchestration engine for scan-resolve-capture-review-save add-product flow.
//

import Foundation
import InventoryModule

actor AddProductFlowUseCase {
    private let inventoryModuleService: any InventoryModuleTypes.InventoryModuleServicing
    private let inventoryModuleLocationRepository: any InventoryModuleTypes.LocationRepository
    private let inventoryModuleRepository: any InventoryModuleTypes.InventoryRepository
    private let catalogService: any AddProductCatalogServicing
    private let householdProvider: any HouseholdContextProviding

    private var state: AddProductState = .idle
    private var subscribers: [UUID: AsyncStream<AddProductState>.Continuation] = [:]

    private var currentInventoryHit: (item: InventoryItem, source: ProductDataSource)?
    private var currentCatalogHit: (item: ProductCatalogItem, source: ProductDataSource)?
    private var currentNotFoundContext: AddProductNotFoundContext?

    init(
        inventoryModuleService: any InventoryModuleTypes.InventoryModuleServicing,
        inventoryModuleLocationRepository: any InventoryModuleTypes.LocationRepository,
        inventoryModuleRepository: any InventoryModuleTypes.InventoryRepository,
        catalogService: any AddProductCatalogServicing,
        householdProvider: any HouseholdContextProviding
    ) {
        self.inventoryModuleService = inventoryModuleService
        self.inventoryModuleLocationRepository = inventoryModuleLocationRepository
        self.inventoryModuleRepository = inventoryModuleRepository
        self.catalogService = catalogService
        self.householdProvider = householdProvider
    }

    func observeState() -> AsyncStream<AddProductState> {
        AsyncStream { continuation in
            let id = UUID()
            subscribers[id] = continuation
            continuation.yield(state)
            continuation.onTermination = { _ in
                Task { await self.removeSubscriber(id) }
            }
        }
    }

    func snapshotState() -> AddProductState {
        state
    }

    func start() async {
        transition(to: .scanning)
    }

    func resetAndScan() async {
        currentInventoryHit = nil
        currentCatalogHit = nil
        currentNotFoundContext = nil
        transition(to: .scanning)
    }

    func handleBarcode(_ barcode: Barcode) async {
        transition(to: .resolving(barcode: barcode))

        do {
            let householdId = try await householdProvider.currentHouseholdId()

            if let moduleInventory = try await findInventoryFromModule(
                householdId: householdId,
                barcode: barcode
            ) {
                currentInventoryHit = (moduleInventory, .inventoryLocal)
                currentCatalogHit = nil
                currentNotFoundContext = nil
                let localCatalog = await loadCatalogForInventory(moduleInventory)
                let draft = makeInventoryDraft(
                    item: moduleInventory,
                    catalog: localCatalog,
                    source: .inventoryLocal,
                    isEditable: false
                )
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            if let localCatalog = try await catalogService.retrieveLocalCatalog(byBarcode: barcode) {
                currentCatalogHit = (localCatalog, .catalogLocal)
                currentInventoryHit = nil
                currentNotFoundContext = nil
                let draft = makeCatalogDraft(item: localCatalog, source: .catalogLocal, isEditable: false)
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            if let remoteCatalog = try? await catalogService.retrieveCatalog(byBarcode: barcode) {
                currentCatalogHit = (remoteCatalog, .catalogRemote)
                currentInventoryHit = nil
                currentNotFoundContext = nil
                let draft = makeCatalogDraft(item: remoteCatalog, source: .catalogRemote, isEditable: false)
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            currentInventoryHit = nil
            currentCatalogHit = nil
            let context = AddProductNotFoundContext.barcodeMiss(barcode)
            currentNotFoundContext = context
            transition(to: .barcodeNotFound(context: context))
        } catch {
            transition(to: .failure(message: "Failed to resolve barcode. Please try again."))
        }
    }

    func continueFromCatalogHit() async {
        guard let currentCatalogHit else {
            transition(to: .failure(message: "No catalog item selected."))
            return
        }
        let draft = makeCatalogDraft(
            item: currentCatalogHit.item,
            source: currentCatalogHit.source,
            isEditable: false
        )
        transition(to: .reviewing(draft: draft, isEditable: false))
    }

    func skipBarcodeAndCaptureImages() async {
        let context = currentNotFoundContext ?? AddProductNotFoundContext.barcodeMiss(nil)
        currentNotFoundContext = context
        transition(to: .captureImages(context: context, plan: .productAnalysisDefault))
    }

    func openManualEntry(prefilledTitle: String? = nil) async {
        let draft = makeManualDraft()
        if let prefilledTitle {
            var updatedDraft = draft
            let trimmedTitle = prefilledTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedTitle.isNotEmpty {
                updatedDraft.title = trimmedTitle
            }
            transition(to: .manualEntry(draft: updatedDraft))
            return
        }
        transition(to: .manualEntry(draft: draft))
    }

    func reviewCatalogProduct(_ item: ProductCatalogItem, source: ProductDataSource) async {
        currentCatalogHit = (item, source)
        currentInventoryHit = nil
        currentNotFoundContext = nil
        let draft = makeCatalogDraft(item: item, source: source, isEditable: false)
        transition(to: .reviewing(draft: draft, isEditable: false))
    }

    func reviewDraft(_ draft: ProductDraft, isEditable: Bool) async {
        transition(to: .reviewing(draft: draft, isEditable: isEditable))
    }

    func saveDraft(_ draft: ProductDraft) async {
        transition(to: .saving)

        do {
            let householdId = try await householdProvider.currentHouseholdId()
            let normalizedBarcode = draft.barcode?.value.trimmingCharacters(in: .whitespacesAndNewlines)
            let hasBarcode = normalizedBarcode?.isEmpty == false
            let barcode = hasBarcode ? draft.barcode : nil

            if let barcode {
                let catalogItem = makeCatalogItem(from: draft, barcode: barcode)
                try await catalogService.upsertCatalog(catalogItem)
            } else {
                logger.error("barcode not found")
            }

            let inventory = makeInventoryItem(from: draft, householdId: householdId, barcode: barcode)
            let didSave = await saveInventory(inventory, draft: draft)
            guard didSave else { return }
            transition(to: .success(savedItemId: inventory.id))
        } catch {
            transition(to: .failure(message: "Unable to save product. Please try again."))
        }
    }

    func handleCapturedImages(_ images: [ImagesCaptured]) async {
        transition(to: .extracting(images))
    }

    func quickAddOne() async {
        guard let currentInventoryHit else {
            transition(to: .failure(message: "No inventory item available for quick add."))
            return
        }

        var updated = currentInventoryHit.item
        if updated.batches.isEmpty {
            updated.batches = [InventoryBatch(quantity: 1)]
        } else {
            let lastIndex = updated.batches.index(before: updated.batches.endIndex)
            updated.batches[lastIndex].quantity += 1
        }
        updated.updatedAt = Date()

        let didSave = await saveInventory(updated)
        guard didSave else { return }
        self.currentInventoryHit = (updated, currentInventoryHit.source)
        transition(to: .success(savedItemId: updated.id))
    }

    func quickAddBatch() async {
        guard let currentInventoryHit else {
            transition(to: .failure(message: "No inventory item available for new batch."))
            return
        }

        var updated = currentInventoryHit.item
        let defaultUnit = updated.batches.last?.unit
        updated.batches.append(InventoryBatch(quantity: 1, unit: defaultUnit))
        updated.updatedAt = Date()

        let didSave = await saveInventory(updated)
        guard didSave else { return }
        self.currentInventoryHit = (updated, currentInventoryHit.source)
        transition(to: .success(savedItemId: updated.id))
    }

    func editDatesForInventoryHit() async {
        guard let currentInventoryHit else {
            transition(to: .failure(message: "No inventory item available to edit."))
            return
        }

        let localCatalog = await loadCatalogForInventory(currentInventoryHit.item)
        let draft = makeInventoryDraft(
            item: currentInventoryHit.item,
            catalog: localCatalog,
            source: currentInventoryHit.source,
            isEditable: false
        )
        transition(to: .reviewing(draft: draft, isEditable: false))
    }

    
}

private extension AddProductFlowUseCase {
    func transition(to next: AddProductState) {
        state = next
        for continuation in subscribers.values {
            continuation.yield(next)
        }
    }

    func removeSubscriber(_ id: UUID) {
        subscribers[id] = nil
    }

    func registerInventoryHit(_ item: InventoryItem, source: ProductDataSource) {
        currentInventoryHit = (item, source)
        currentCatalogHit = nil
        currentNotFoundContext = nil
        transition(to: .inventoryFound(item: item, source: source))
    }

    func registerCatalogHit(_ item: ProductCatalogItem, source: ProductDataSource) {
        currentCatalogHit = (item, source)
        currentInventoryHit = nil
        currentNotFoundContext = nil
        transition(to: .catalogFound(item: item, source: source))
    }

    func loadCatalogForInventory(_ item: InventoryItem) async -> ProductCatalogItem? {
        if let refId = item.catalogRefId,
           refId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
           let local = try? await catalogService.retrieveLocalCatalog(productId: refId) {
            return local
        }

        if let barcode = item.barcode,
           let local = try? await catalogService.retrieveLocalCatalog(byBarcode: barcode) {
            return local
        }

        return nil
    }

    func inventoryItemID(householdId: String, barcode: Barcode) -> String {
        "\(householdId)_\(barcode.value)"
    }

    func saveInventory(_ item: InventoryItem, draft: ProductDraft? = nil) async -> Bool {
        do {
            let locationID = try await ensureDefaultStorageLocation(for: item.householdId)
            let input = try makeInventoryModuleAddInput(
                from: item,
                draft: draft,
                storageLocationId: locationID
            )
            _ = try await inventoryModuleService.addInventoryItem(input)
            return true
        } catch {
            transition(to: .failure(message: "Unable to persist inventory item locally."))
            return false
        }
    }

    func findInventoryFromModule(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        let normalizedProductID = barcode.value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedProductID.isNotEmpty else { return nil }

        let batches = try await inventoryModuleRepository.fetchActiveBatches(
            productId: normalizedProductID,
            householdId: householdId
        )
        guard let match = batches.first else { return nil }

        let quantityInt = max(
            Int(match.quantity.value.rounded(.down)),
            1
        )
        let unitString = moduleQuantityUnitString(match.quantity.unit)
        let mappedBarcode = Barcode(value: normalizedProductID, symbology: barcode.symbology)

        return InventoryItem(
            id: match.id,
            householdId: match.householdId,
            barcode: mappedBarcode,
            catalogRefId: match.productRef.productId,
            batches: [InventoryBatch(quantity: quantityInt, unit: unitString)],
            updatedAt: match.updatedAt,
            needsBarcode: false
        )
    }

    func ensureDefaultStorageLocation(for householdId: String) async throws -> String {
        let defaultLocationID = "default-pantry-\(householdId)"
        if let existing = try await inventoryModuleLocationRepository.findById(
            defaultLocationID,
            householdId: householdId
        ) {
            return existing.id
        }

        let now = Date()
        let location = InventoryModuleTypes.StorageLocation(
            id: defaultLocationID,
            householdId: householdId,
            name: "Pantry",
            isColdStorage: false,
            createdAt: now,
            updatedAt: now
        )
        try await inventoryModuleLocationRepository.upsert(location)
        return defaultLocationID
    }

    func makeInventoryModuleAddInput(
        from item: InventoryItem,
        draft: ProductDraft?,
        storageLocationId: String
    ) throws -> InventoryModuleTypes.AddInventoryItemInput {
        let productID = resolvedProductID(from: item)
        let totalQuantity = max(item.batches.reduce(0) { $0 + max($1.quantity, 0) }, 1)
        let preferredUnit = item.batches.last?.unit
        let expiryInfo = draft.flatMap(mappedExpiryInfo(from:))
        let openedInfo = draft.flatMap(mappedOpenedInfo(from:))

        return InventoryModuleTypes.AddInventoryItemInput(
            householdId: item.householdId,
            productRef: ProductRef(productId: productID),
            quantity: Quantity(
                value: Double(totalQuantity),
                unit: mappedModuleQuantityUnit(from: preferredUnit)
            ),
            storageLocationId: storageLocationId,
            expiryInfo: expiryInfo,
            openedInfo: openedInfo,
            lotOrBatchCode: nil,
            idempotencyRequestId: UUID().uuidString
        )
    }

    func mappedExpiryInfo(from draft: ProductDraft) -> InventoryDateInfo? {
        let candidates = draft.dateEntries.compactMap(mappedInventoryDateInfo(from:))
        if let explicitExpiry = candidates.first(where: { $0.kind == .expiry }) {
            return explicitExpiry
        }
        if let useBy = candidates.first(where: { $0.kind == .useBy }) {
            return useBy
        }
        if let bestBefore = candidates.first(where: { $0.kind == .bestBefore }) {
            return bestBefore
        }
        return nil
    }

    func mappedOpenedInfo(from _: ProductDraft) -> InventoryDateInfo? {
        nil
    }

    func mappedInventoryDateInfo(from entry: ProductDraftDateEntry) -> InventoryDateInfo? {
        guard let isoDate = entry.value else { return nil }
        let kind = mappedInventoryDateKind(from: entry.kind)
        guard let kind else { return nil }

        return InventoryDateInfo(
            kind: kind,
            rawText: iso8601DateString(from: isoDate),
            confidence: entry.inputMode == .manualCalendar ? 1.0 : 0.8,
            isoDate: isoDate
        )
    }

    func mappedInventoryDateKind(from kind: ProductDateInfo.Kind) -> InventoryDateKind? {
        switch kind {
        case .expiry:
            return .expiry
        case .bestBefore:
            return .bestBefore
        case .useBy:
            return .useBy
        case .manufactured:
            return .manufactured
        case .packedOn:
            return .packaged
        case .unknown:
            return nil
        }
    }

    func iso8601DateString(from date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: date)
    }

    func resolvedProductID(from item: InventoryItem) -> String {
        let barcodeValue = item.barcode?.value.trimmingCharacters(in: .whitespacesAndNewlines)
        if let barcodeValue, barcodeValue.isNotEmpty {
            return barcodeValue
        }
        let catalogRef = item.catalogRefId?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let catalogRef, catalogRef.isNotEmpty {
            return catalogRef
        }
        return item.id
    }

    func mappedModuleQuantityUnit(from legacyUnit: String?) -> QuantityUnit {
        guard let legacyUnit = legacyUnit?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
              legacyUnit.isNotEmpty else {
            return .piece
        }

        switch legacyUnit {
        case "g", "gram", "grams":
            return .gram
        case "kg", "kilogram", "kilograms":
            return .kilogram
        case "ml", "milliliter", "milliliters":
            return .milliliter
        case "l", "liter", "liters":
            return .liter
        case "pack", "pkt", "package":
            return .pack
        default:
            return .piece
        }
    }

    func moduleQuantityUnitString(_ unit: QuantityUnit) -> String {
        switch unit {
        case .piece:
            return "piece"
        case .gram:
            return "g"
        case .kilogram:
            return "kg"
        case .milliliter:
            return "ml"
        case .liter:
            return "l"
        case .pack:
            return "pack"
        }
    }

    func makeCatalogDraft(item: ProductCatalogItem, source: ProductDataSource, isEditable: Bool) -> ProductDraft {
        ProductDraft(
            id: item.id,
            source: source,
            isEditable: isEditable,
            barcode: item.barcode,
            catalog: item,
            title: item.title,
            brand: item.brand,
            description: item.description,
            categories: item.categories,
            category: nil,
            productDetail: nil,
            size: item.size,
            images: [],
            quantity: 1,
            numberOfItems: 1,
            unit: nil,
            dateEntries: [],
            notes: nil,
            lockedFields: isEditable ? [] : Set(ProductField.allCases),
            fieldConfidences: [:]
        )
    }

    func makeInventoryDraft(
        item: InventoryItem,
        catalog: ProductCatalogItem?,
        source: ProductDataSource,
        isEditable: Bool
    ) -> ProductDraft {
        let quantity = item.batches.reduce(0) { $0 + $1.quantity }
        let unit = item.batches.last?.unit

        return ProductDraft(
            id: item.id,
            source: source,
            isEditable: isEditable,
            barcode: item.barcode,
            catalog: catalog,
            title: catalog?.title,
            brand: catalog?.brand,
            description: catalog?.description,
            categories: catalog?.categories,
            category: nil,
            productDetail: nil,
            size: catalog?.size,
            images: [],
            quantity: max(1, quantity),
            numberOfItems: max(1, quantity),
            unit: unit,
            dateEntries: [],
            notes: nil,
            lockedFields: isEditable ? [] : Set(ProductField.allCases),
            fieldConfidences: [:]
        )
    }

    func makeManualDraft() -> ProductDraft {
        let barcode = currentNotFoundContext?.barcode
        return ProductDraft(
            id: barcode?.value ?? UUID().uuidString,
            source: .manual,
            isEditable: true,
            barcode: barcode,
            catalog: nil,
            title: nil,
            brand: nil,
            description: nil,
            categories: nil,
            category: nil,
            productDetail: nil,
            size: nil,
            images: [],
            quantity: 1,
            numberOfItems: 1,
            unit: nil,
            dateEntries: [],
            notes: nil,
            lockedFields: [],
            fieldConfidences: [:]
        )
    }

    func makeCatalogItem(from draft: ProductDraft, barcode: Barcode) -> ProductCatalogItem {
        ProductCatalogItem(
            id: barcode.value,
            barcode: barcode,
            title: draft.title,
            brand: draft.brand,
            description: draft.description,
            images: nil,
            categories: draft.categories,
            size: draft.size
        )
    }

    func makeInventoryItem(from draft: ProductDraft, householdId: String, barcode: Barcode?) -> InventoryItem {
        let fallbackID = UUID().uuidString
        let itemID: String
        if let barcode {
            itemID = inventoryItemID(householdId: householdId, barcode: barcode)
        } else {
            itemID = "\(householdId)_\(fallbackID)"
        }

        let unit = draft.unit?.trimmingCharacters(in: .whitespacesAndNewlines)
        let batch = InventoryBatch(
            quantity: max(1, draft.numberOfItems),
            unit: unit?.isEmpty == true ? nil : unit,
            notes: draft.notes
        )
        let catalogRefId = barcode?.value

        return InventoryItem(
            id: itemID,
            householdId: householdId,
            barcode: barcode,
            catalogRefId: catalogRefId,
            batches: [batch],
            updatedAt: Date(),
            needsBarcode: barcode == nil
        )
    }
}

// MARK: Test Plan
// 1. Validate inventory-local hit short-circuits remote/catalog lookups.
// 2. Validate local catalog lookup runs through AddProductCatalogServicing before remote fallbacks.
// 3. Validate saveDraft upserts product data through AddProductCatalogServicing, then persists inventory through InventoryModule.
// 4. Validate lock rules are present on drafts produced from inventory/catalog vs extraction.
