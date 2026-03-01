//
//  ProductDataSource.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Source markers for how Add Product resolved or built item data.
//

import Foundation

enum ProductDataSource: String, Codable, Sendable, Equatable, Hashable {
    case inventoryLocal = "inventory_local"
    case inventoryRemote = "inventory_remote"
    case catalogLocal = "catalog_local"
    case catalogRemote = "catalog_remote"
    case aiExtraction = "ai_extraction"
    case manual
}
