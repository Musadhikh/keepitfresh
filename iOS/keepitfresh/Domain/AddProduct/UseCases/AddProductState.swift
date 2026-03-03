//
//  AddProductState.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Add Product flow state machine used by the actor use case and UI.
//

import Foundation

enum AddProductState: Sendable, Equatable, CustomStringConvertible {
    case idle
    case scanning
    case resolving(barcode: Barcode)
    case inventoryFound(item: InventoryItem, source: ProductDataSource)
    case catalogFound(item: ProductCatalogItem, source: ProductDataSource)
    case barcodeNotFound(context: AddProductNotFoundContext)
    case captureImages(context: AddProductNotFoundContext, plan: AddProductCapturePlan)
    case extracting([ImagesCaptured])
    case manualEntry(draft: ProductDraft)
    case reviewing(draft: ProductDraft, isEditable: Bool)
    case saving
    case success(savedItemId: String)
    case failure(message: String)
    
    var description: String {
        return switch self {
            case .barcodeNotFound: "barcodeNotFound"
            case .captureImages: "captureImages"
            case .catalogFound: "catalogFound"
            case .extracting: "extracting"
            case .failure: "failure"
            case .idle: "idle"
            case .inventoryFound: "inventoryFound"
            case .manualEntry: "manualEntry"
            case .resolving: "resolving"
            case .reviewing: "reviewing"
            case .saving: "saving"
            case .scanning: "scanning"
            case .success: "success"
                
        }
    }
}
