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
        transition(to: .scanning)
    }

    func handleBarcode(_ barcode: Barcode) async {
        transition(to: .resolving(barcode: barcode))

        do {
            let householdId = try await householdProvider.currentHouseholdId()
            
            if let localInventory = try await inventoryRepository.findLocal(householdId: householdId, barcode: barcode) {
                registerInventoryHit(localInventory, source: .inventoryLocal)
                return
            }

            async let remoteInventoryTask: InventoryItem? = try? await inventoryRepository.findRemote(householdId: householdId, barcode: barcode)
            async let localCatalogTask: ProductCatalogItem? = try? await catalogRepository.findLocal(barcode: barcode)

            let remoteInventory = await remoteInventoryTask
            if let remoteInventory {
                try? await inventoryRepository.upsertLocal(remoteInventory)
                registerInventoryHit(remoteInventory, source: .inventoryRemote)
                return
            }

            let localCatalog = await localCatalogTask
            if let localCatalog {
                registerCatalogHit(localCatalog, source: .catalogLocal)
                return
            }

            if let remoteCatalog = try? await catalogRepository.findRemote(barcode: barcode) {
                try? await catalogRepository.cacheLocal(remoteCatalog)
                registerCatalogHit(remoteCatalog, source: .catalogRemote)
                return
            }

            currentInventoryHit = nil
            currentCatalogHit = nil
            transition(to: .captureImages)
        } catch {
            transition(to: .failure(message: "Failed to resolve barcode. Please try again."))
        }
    }

    func continueFromCatalogHit() async {
        guard let currentCatalogHit else {
            transition(to: .failure(message: "No catalog item selected."))
            return
        }

//        var draft = draftBuilder.fromCatalog(currentCatalogHit.item, barcode: currentCatalogHit.item.barcode)
//        draft.source = currentCatalogHit.source
//        transition(to: .reviewing(draft: draft))
    }

    func skipBarcodeAndCaptureImages() async {
        transition(to: .captureImages)
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
//        var draft = draftBuilder.fromInventory(currentInventoryHit.item, catalog: localCatalog)
//        draft.source = currentInventoryHit.source
//        transition(to: .reviewing(draft: draft))
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
        transition(to: .inventoryFound(item: item, source: source))
    }

    func registerCatalogHit(_ item: ProductCatalogItem, source: ProductDataSource) {
        currentCatalogHit = (item, source)
        currentInventoryHit = nil
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
}

// MARK: Test Plan
// 1. Validate inventory-local hit short-circuits remote/catalog lookups.
// 2. Validate inventory-remote beats catalog-local when both are available.
// 3. Validate saveDraft performs local upsert before remote and enqueues on remote failure.
// 4. Validate lock rules are present on drafts produced from inventory/catalog vs extraction.
