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
    let catalogService: any AddProductCatalogServicing
    let householdContextProvider: any HouseholdContextProviding

    init(
        inventoryRepository: (any InventoryRepository)? = nil,
        catalogService: (any AddProductCatalogServicing)? = nil,
        householdContextProvider: (any HouseholdContextProviding)? = nil,
        defaultHouseholdId: String = "default-household"
    ) {
        self.inventoryRepository = inventoryRepository ?? RealmInventoryRepository()
        #if canImport(Factory)
        self.catalogService = catalogService ?? Container.shared.addProductCatalogService()
        #else
        guard let catalogService else {
            preconditionFailure("AddProductCatalogServicing is required when Factory is unavailable.")
        }
        self.catalogService = catalogService
        #endif
        self.householdContextProvider = householdContextProvider ?? DefaultHouseholdContextProvider(householdId: defaultHouseholdId)
    }

    func makeUseCase() -> AddProductFlowUseCase {
        AddProductFlowUseCase(
            inventoryRepository: inventoryRepository,
            catalogService: catalogService,
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
        self {
            AddProductModuleAssembler(
                inventoryRepository: self.addProductInventoryRepository(),
                catalogService: self.addProductCatalogService()
            )
        }
        .singleton
    }
}
#endif


struct DefaultHouseholdContextProvider: HouseholdContextProviding {
    let householdId: String

    func currentHouseholdId() async throws -> String {
        householdId
    }
}
