//
//  InventoryItemDTO.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines transfer representation of inventory items for persistence adapters.
//

import Foundation
import InventoryDomain

public struct InventoryItemDTO: Sendable, Codable, Equatable, Hashable {
    public var item: InventoryItem

    public init(item: InventoryItem) {
        self.item = item
    }
}

