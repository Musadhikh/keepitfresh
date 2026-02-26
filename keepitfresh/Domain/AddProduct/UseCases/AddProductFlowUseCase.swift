//
//  AddProductFlowUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Actor orchestration engine for scan-resolve-capture-review-save add-product flow.
//

import Foundation

actor AddProductFlowUseCase {
    private let inventoryRepository: any InventoryRepository
    private let catalogRepository: any CatalogRepository
    private let householdProvider: any HouseholdContextProviding

    private var state: AddProductState = .idle
    private var subscribers: [UUID: AsyncStream<AddProductState>.Continuation] = [:]

    private var currentInventoryHit: (item: InventoryItem, source: ProductDataSource)?
    private var currentCatalogHit: (item: ProductCatalogItem, source: ProductDataSource)?
    private var currentNotFoundContext: AddProductNotFoundContext?

    init(
        inventoryRepository: any InventoryRepository,
        catalogRepository: any CatalogRepository,
        householdProvider: any HouseholdContextProviding
    ) {
        self.inventoryRepository = inventoryRepository
        self.catalogRepository = catalogRepository
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
            
            if let localInventory = try await inventoryRepository.findLocal(householdId: householdId, barcode: barcode) {
                currentInventoryHit = (localInventory, .inventoryLocal)
                currentCatalogHit = nil
                let localCatalog = await loadCatalogForInventory(localInventory)
                let draft = makeInventoryDraft(
                    item: localInventory,
                    catalog: localCatalog,
                    source: .inventoryLocal,
                    isEditable: false
                )
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            async let remoteInventoryTask: InventoryItem? = try? await inventoryRepository.findRemote(householdId: householdId, barcode: barcode)
            async let localCatalogTask: ProductCatalogItem? = try? await catalogRepository.findLocal(barcode: barcode)

            let remoteInventory = await remoteInventoryTask
            if let remoteInventory {
                try? await inventoryRepository.upsertLocal(remoteInventory)
                currentInventoryHit = (remoteInventory, .inventoryRemote)
                currentCatalogHit = nil
                let localCatalog = await loadCatalogForInventory(remoteInventory)
                let draft = makeInventoryDraft(
                    item: remoteInventory,
                    catalog: localCatalog,
                    source: .inventoryRemote,
                    isEditable: false
                )
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            let localCatalog = await localCatalogTask
            if let localCatalog {
                currentCatalogHit = (localCatalog, .catalogLocal)
                currentInventoryHit = nil
                let draft = makeCatalogDraft(item: localCatalog, source: .catalogLocal, isEditable: false)
                transition(to: .reviewing(draft: draft, isEditable: false))
                return
            }

            if let remoteCatalog = try? await catalogRepository.findRemote(barcode: barcode) {
                try? await catalogRepository.cacheLocal(remoteCatalog)
                currentCatalogHit = (remoteCatalog, .catalogRemote)
                currentInventoryHit = nil
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

    func openManualEntry() async {
        let draft = makeManualDraft()
        transition(to: .manualEntry(draft: draft))
    }

    func saveDraft(_ draft: ProductDraft) async {
        transition(to: .saving)

        do {
            let householdId = try await householdProvider.currentHouseholdId()
            let normalizedBarcode = draft.barcode?.value.trimmingCharacters(in: .whitespacesAndNewlines)
            let hasBarcode = normalizedBarcode?.isEmpty == false
            let barcode = hasBarcode ? draft.barcode : nil

            if let barcode {
                let localCatalog = try await catalogRepository.findLocal(barcode: barcode)
                if localCatalog == nil {
                    let catalogItem = makeCatalogItem(from: draft, barcode: barcode)
                    try await catalogRepository.cacheLocal(catalogItem)

                    let remoteCatalog = try? await catalogRepository.findRemote(barcode: barcode)
                    if remoteCatalog == nil {
                        try? await catalogRepository.upsertRemote(catalogItem)
                    }
                }
            }

            let inventory = makeInventoryItem(from: draft, householdId: householdId, barcode: barcode)
            let didSave = await saveInventoryWithFallback(inventory)
            guard didSave else { return }
            transition(to: .success(savedItemId: inventory.id))
        } catch {
            transition(to: .failure(message: "Unable to save product. Please try again."))
        }
    }

    func handleCapturedImages(_ images: [ImagesCaptured]) async {
        transition(to: .extracting(images))

//        do {
//            let extraction = try await visionExtractor.extract(from: images)
//            
//            let prompt = PromptType.inventory(extraction)
//            
//            let data = try await dataBuilder.generateData(from: prompt, type: ExtractedData.self)
//            
//            
//            transition(to: .reviewing(draft: draft))
//        } catch {
//            transition(to: .failure(message: "Could not extract product details from images."))
//        }
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

        let didSave = await saveInventoryWithFallback(updated)
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

        let didSave = await saveInventoryWithFallback(updated)
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
           let barcode = item.barcode,
           refId == barcode.value,
           let local = try? await catalogRepository.findLocal(barcode: barcode) {
            return local
        }

        if let barcode = item.barcode,
           let local = try? await catalogRepository.findLocal(barcode: barcode) {
            return local
        }

        return nil
    }

    func inventoryItemID(householdId: String, barcode: Barcode) -> String {
        "\(householdId)_\(barcode.value)"
    }

    func ensureCatalogExists(from draft: ProductDraft, barcode: Barcode) async throws {
        if let catalog = draft.catalog {
            try await catalogRepository.cacheLocal(catalog)
            return
        }

        let item = ProductCatalogItem(
            id: barcode.value,
            barcode: barcode,
            title: draft.title,
            brand: draft.brand,
            description: draft.description,
            images: nil,
            categories: draft.categories,
            size: draft.size
        )
        try await catalogRepository.cacheLocal(item)
    }

    func saveInventoryWithFallback(_ item: InventoryItem) async -> Bool {
        do {
            try await inventoryRepository.upsertLocal(item)
            do {
                try await inventoryRepository.upsertRemote(item)
            } catch {
                await inventoryRepository.enqueueSync(.upsertInventory(item))
            }
            return true
        } catch {
            transition(to: .failure(message: "Unable to persist inventory item locally."))
            return false
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
// 2. Validate inventory-remote beats catalog-local when both are available.
// 3. Validate saveDraft performs local upsert before remote and enqueues on remote failure.
// 4. Validate lock rules are present on drafts produced from inventory/catalog vs extraction.
