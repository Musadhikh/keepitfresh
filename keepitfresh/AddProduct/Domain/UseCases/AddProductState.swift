//
//  AddProductState.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Add Product flow state machine used by the actor use case and UI.
//

import Foundation

enum AddProductState: Sendable, Equatable {
    case idle
    case scanning
    case resolving(barcode: Barcode)
    case inventoryFound(item: InventoryItem, source: ProductDataSource)
    case catalogFound(item: ProductCatalogItem, source: ProductDataSource)
    case captureImages
    case extracting([ImagesCaptured])
    case reviewing(draft: ProductDraft)
    case saving
    case success(savedItemId: String)
    case failure(message: String)
}
