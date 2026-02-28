//
//  InventoryItemMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Maps inventory items to/from DTOs for adapter boundary consistency.
//

import Foundation
import InventoryDomain

public enum InventoryItemMapper {
    public static func toDTO(_ item: InventoryItem) -> InventoryItemDTO {
        InventoryItemDTO(item: item)
    }

    public static func fromDTO(_ dto: InventoryItemDTO) -> InventoryItem {
        dto.item
    }
}

