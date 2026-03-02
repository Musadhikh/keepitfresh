//
//  AddProductFlowDraftMapperTests.swift
//  keepitfreshTests
//
//  Created by musadhikh on 2/3/26.
//  Summary: Verifies Add Product UI-to-domain mapper behavior for extraction and product search flows.
//

import Foundation
import Testing
import ProductModule
@testable import keepitfresh

@Suite("AddProductFlowDraftMapper")
struct AddProductFlowDraftMapperTests {
    @Test("Extraction review draft maps to ProductDraft with expected dates and barcode")
    func extractionReviewToDraftMapping() {
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let manufactured = Date(timeIntervalSince1970: 1_690_000_000)
        let extraction = AddProductExtractionReviewDraft(
            productName: "Lipton Tea",
            brand: "Lipton",
            category: .beverage,
            subCategory: "Tea",
            expiryDate: now,
            manufacturedDate: manufactured,
            includeManufacturedDate: true,
            barcode: "8720608629091"
        )

        let draft = AddProductFlowDraftMapper.makeDraft(from: extraction)

        #expect(draft.title == "Lipton Tea")
        #expect(draft.brand == "Lipton")
        #expect(draft.barcode?.value == "8720608629091")
        #expect(draft.category?.main == .beverage)
        #expect(draft.category?.subCategory == "Tea")
        #expect(draft.dateEntries.contains(where: { $0.kind == .expiry && $0.value == now }))
        #expect(draft.dateEntries.contains(where: { $0.kind == .manufactured && $0.value == manufactured }))
    }

    @Test("Search product maps to ProductCatalogItem with fallback barcode and category flattening")
    func searchProductToCatalogItemMapping() {
        let product = ProductModuleTypes.Product(
            productId: "0002000005801",
            barcode: nil,
            title: "Whole Milk",
            brand: "Farm Brand",
            shortDescription: "Fresh milk",
            category: ProductModuleTypes.ProductCategory(main: .food, sub: "Dairy"),
            images: [
                ProductModuleTypes.ProductImage(urlString: "https://example.com/image-1.jpg")
            ]
        )

        let catalogItem = AddProductFlowDraftMapper.makeCatalogItem(from: product)

        #expect(catalogItem.id == "0002000005801")
        #expect(catalogItem.barcode.value == "0002000005801")
        #expect(catalogItem.title == "Whole Milk")
        #expect(catalogItem.brand == "Farm Brand")
        #expect(catalogItem.categories == ["food", "Dairy"])
        #expect(catalogItem.images?.count == 1)
    }

    @Test("Extraction mapping omits manufactured date when toggle is disabled")
    func extractionMappingWithoutManufacturedDate() {
        let extraction = AddProductExtractionReviewDraft(
            productName: "Tomato",
            brand: "",
            category: .food,
            subCategory: "",
            expiryDate: Date(timeIntervalSince1970: 1_700_000_000),
            manufacturedDate: Date(timeIntervalSince1970: 1_690_000_000),
            includeManufacturedDate: false,
            barcode: ""
        )

        let draft = AddProductFlowDraftMapper.makeDraft(from: extraction)
        let manufacturedEntries = draft.dateEntries.filter { $0.kind == .manufactured }

        #expect(draft.barcode == nil)
        #expect(manufacturedEntries.isEmpty)
    }
}
