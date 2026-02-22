//
//  DraftBuilding.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Builds ProductDraft objects from inventory/catalog/extraction inputs.
//

import Foundation

protocol DraftBuilding: Sendable {
    func fromInventory(_ item: InventoryItem, catalog: ProductCatalogItem?) -> ProductDraft
    func fromCatalog(_ item: ProductCatalogItem, barcode: Barcode) -> ProductDraft
    func fromExtraction(_ extraction: ProductExtractionResult, preferredBarcode: Barcode?) -> ProductDraft
}
