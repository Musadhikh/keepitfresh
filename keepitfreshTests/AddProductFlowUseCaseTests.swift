//
//  AddProductFlowUseCaseTests.swift
//  keepitfreshTests
//
//  Created by musadhikh on 20/2/26.
//  Summary: Covers Add Product flow orchestration behavior (resolution priority, locks, offline-first save).
//

import Foundation
import Testing
@testable import keepitfresh

@Suite("AddProductFlowUseCase")
struct AddProductFlowUseCaseTests {
    @Test("Resolution prefers inventory over catalog when both remote inventory and local catalog hit")
    func resolutionPriorityInventoryBeatsCatalog() async throws {
        let barcode = Barcode(value: "1234567890123", symbology: .ean13)
        let householdId = "house-1"

        let remoteInventory = InventoryItem(
            id: "\(householdId)_\(barcode.value)",
            householdId: householdId,
            barcode: barcode,
            catalogRefId: barcode.value,
            batches: [InventoryBatch(quantity: 2)],
            updatedAt: Date(),
            needsBarcode: false
        )

        let localCatalog = ProductCatalogItem(
            id: barcode.value,
            barcode: barcode,
            title: "Catalog Tea",
            brand: "Brand",
            description: "desc",
            images: nil,
            categories: ["beverage"],
            size: "100g"
        )

        let inventoryRepository = InMemoryInventoryRepository(
            localItems: [],
            remoteItems: [remoteInventory],
            remoteAvailable: true
        )
        let catalogRepository = InMemoryCatalogRepository(
            localItems: [localCatalog],
            remoteItems: [],
            remoteAvailable: false
        )

        let useCase = AddProductFlowUseCase(
            inventoryRepository: inventoryRepository,
            catalogRepository: catalogRepository,
            visionExtractor: StubVisionExtractor(),
            draftBuilder: AddProductDraftBuilder(),
            householdProvider: DefaultHouseholdContextProvider(householdId: householdId)
        )

        await useCase.handleBarcode(barcode)
        let state = await useCase.snapshotState()

        #expect(state == .inventoryFound(item: remoteInventory, source: .inventoryRemote))
    }

    @Test("Locking rules: inventory/catalog lock core fields, extraction remains editable")
    func lockingRules() {
        let barcode = Barcode(value: "5555555555555", symbology: .ean13)
        let catalog = ProductCatalogItem(
            id: barcode.value,
            barcode: barcode,
            title: "Soap",
            brand: "Care",
            description: "desc",
            images: nil,
            categories: ["personal care"],
            size: "200ml"
        )
        let inventory = InventoryItem(
            id: "h_\(barcode.value)",
            householdId: "h",
            barcode: barcode,
            catalogRefId: barcode.value,
            batches: [InventoryBatch(quantity: 1)],
            updatedAt: nil,
            needsBarcode: false
        )

        let builder = AddProductDraftBuilder()

        let inventoryDraft = builder.fromInventory(inventory, catalog: catalog)
        let extractionDraft = builder.fromExtraction(ProductExtractionResult(), preferredBarcode: nil)

        let expectedLocked: Set<ProductField> = [.barcode, .title, .brand, .description, .categories, .size, .images]
        #expect(inventoryDraft.lockedFields == expectedLocked)
        #expect(inventoryDraft.lockedFields.contains(.quantity) == false)
        #expect(extractionDraft.lockedFields.isEmpty)
    }

    @Test("Save is local-first and enqueues sync when remote upsert fails")
    func saveLocalFirstWithEnqueueFallback() async throws {
        let householdId = "default-household"
        let barcode = Barcode(value: "8901234567890", symbology: .ean13)

        let inventoryRepository = InMemoryInventoryRepository(
            localItems: [],
            remoteItems: [],
            remoteAvailable: false
        )
        let catalogRepository = InMemoryCatalogRepository()

        let useCase = AddProductFlowUseCase(
            inventoryRepository: inventoryRepository,
            catalogRepository: catalogRepository,
            visionExtractor: StubVisionExtractor(),
            draftBuilder: AddProductDraftBuilder(),
            householdProvider: DefaultHouseholdContextProvider(householdId: householdId)
        )

        let draft = ProductDraft(
            source: .manual,
            barcode: barcode,
            title: "Milk",
            brand: "Farm",
            description: "Fresh milk",
            categories: ["dairy"],
            size: "1L",
            images: [],
            quantity: 1,
            unit: "bottle",
            dateInfo: [],
            notes: "test"
        )

        await useCase.saveDraft(draft)

        let expectedID = "\(householdId)_\(barcode.value)"
        let localItem = await inventoryRepository.localItem(id: expectedID)
        let queuedCount = await inventoryRepository.queuedSyncCount()
        let state = await useCase.snapshotState()

        #expect(localItem != nil)
        #expect(queuedCount == 1)
        #expect(state == .success(savedItemId: expectedID))
    }
}
