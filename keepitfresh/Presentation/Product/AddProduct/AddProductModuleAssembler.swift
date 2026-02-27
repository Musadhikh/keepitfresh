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

    init(
        inventoryRepository: (any InventoryRepository)? = nil,
        catalogRepository: (any CatalogRepository)? = nil,
        householdContextProvider: (any HouseholdContextProviding)? = nil,
        defaultHouseholdId: String = "default-household"
    ) {
        self.inventoryRepository = inventoryRepository ?? RealmInventoryRepository()
        self.catalogRepository = catalogRepository ?? RealmCatalogRepository()
        self.householdContextProvider = householdContextProvider ?? DefaultHouseholdContextProvider(householdId: defaultHouseholdId)
    }

    func makeUseCase() -> AddProductFlowUseCase {
        AddProductFlowUseCase(
            inventoryRepository: inventoryRepository,
            catalogRepository: catalogRepository,
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
                catalogRepository: self.addProductCatalogRepository()
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
