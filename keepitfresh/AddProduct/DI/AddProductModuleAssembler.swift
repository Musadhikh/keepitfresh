//
//  AddProductModuleAssembler.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Composition root for Add Product module with swappable repository dependencies.
//

import Foundation
import SwiftUI
#if canImport(Factory)
import Factory
#endif

struct AddProductModuleAssembler {
    let inventoryRepository: any InventoryRepository
    let catalogRepository: any CatalogRepository
    let householdContextProvider: any HouseholdContextProviding
    let visionExtractor: any VisionExtracting
//    let dataBuilder: any AIDataGenerating

    init(
        inventoryRepository: (any InventoryRepository)? = nil,
        catalogRepository: (any CatalogRepository)? = nil,
        householdContextProvider: (any HouseholdContextProviding)? = nil,
        visionExtractor: (any VisionExtracting)? = nil,
        dataBuilder: (any AIDataGenerating)? = nil,
        defaultHouseholdId: String = "default-household"
    ) {
        self.inventoryRepository = inventoryRepository ?? InMemoryInventoryRepository()
        self.catalogRepository = catalogRepository ?? InMemoryCatalogRepository()
        self.householdContextProvider = householdContextProvider ?? DefaultHouseholdContextProvider(householdId: defaultHouseholdId)
        self.visionExtractor = visionExtractor ?? StubVisionExtractor()
    }

    func makeUseCase() -> AddProductFlowUseCase {
        AddProductFlowUseCase(
            inventoryRepository: inventoryRepository,
            catalogRepository: catalogRepository,
            visionExtractor: visionExtractor,
//            dataBuilder: dataBuilder,
            householdProvider: householdContextProvider
        )
    }

    @MainActor
    func makeViewModel(initialBarcode: Barcode? = nil) -> AddProductViewModel {
        AddProductViewModel(useCase: makeUseCase(), initialBarcode: initialBarcode)
    }

    @MainActor
    func makeRootView(initialBarcode: Barcode? = nil) -> AddProductFlowRootView {
        AddProductFlowRootView(viewModel: makeViewModel(initialBarcode: initialBarcode))
    }
}

#if canImport(Factory)
extension Container {
    var addProductModuleAssembler: Factory<AddProductModuleAssembler> {
        self { AddProductModuleAssembler() }.singleton
    }
}
#endif

struct AddProductDraftBuilder: DraftBuilding {
    private let lockedCatalogFields: Set<ProductField> = [
        .barcode, .title, .brand, .description, .categories, .size, .images
    ]

    func fromInventory(_ item: InventoryItem, catalog: ProductCatalogItem?) -> ProductDraft {
        let latestBatch = item.batches.last

        return ProductDraft(
            source: .inventoryLocal,
            barcode: item.barcode,
            catalog: catalog,
            title: catalog?.title,
            brand: catalog?.brand,
            description: catalog?.description,
            categories: catalog?.categories,
            size: catalog?.size,
            images: [],
            quantity: max(1, latestBatch?.quantity ?? 1),
            unit: latestBatch?.unit,
            dateInfo: latestBatch?.dates ?? [],
            notes: latestBatch?.notes,
            lockedFields: lockedCatalogFields,
            fieldConfidences: [:]
        )
    }

    func fromCatalog(_ item: ProductCatalogItem, barcode: Barcode) -> ProductDraft {
        ProductDraft(
            source: .catalogLocal,
            barcode: barcode,
            catalog: item,
            title: item.title,
            brand: item.brand,
            description: item.description,
            categories: item.categories,
            size: item.size,
            images: [],
            quantity: 1,
            unit: nil,
            dateInfo: [],
            notes: nil,
            lockedFields: lockedCatalogFields,
            fieldConfidences: [:]
        )
    }

    func fromExtraction(_ extraction: ProductExtractionResult, preferredBarcode: Barcode?) -> ProductDraft {
        var confidences: [ProductField: Double] = [:]
        confidences[.title] = extraction.title.confidence
        confidences[.brand] = extraction.brand.confidence
        confidences[.description] = extraction.description.confidence
        confidences[.categories] = extraction.categories.confidence
        confidences[.size] = extraction.size.confidence

        return ProductDraft(
            source: .aiExtraction,
            barcode: preferredBarcode ?? extraction.barcodeCandidates.first,
            catalog: nil,
            title: extraction.title.value,
            brand: extraction.brand.value,
            description: extraction.description.value,
            categories: extraction.categories.value,
            size: extraction.size.value,
            images: [],
            quantity: 1,
            unit: nil,
            dateInfo: extraction.dateInfo ?? [],
            notes: nil,
            lockedFields: [],
            fieldConfidences: confidences.compactMapValues { $0 }
        )
    }
}

struct DefaultHouseholdContextProvider: HouseholdContextProviding {
    let householdId: String

    func currentHouseholdId() async throws -> String {
        householdId
    }
}

struct StubVisionExtractor: VisionExtracting {
    func extract(from images: [ImagesCaptured]) async throws -> [ExtractedType] {
        []
    }
}
