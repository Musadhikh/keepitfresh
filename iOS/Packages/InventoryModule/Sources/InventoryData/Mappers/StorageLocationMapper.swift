//
//  StorageLocationMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Maps storage locations to/from DTOs for adapter boundary consistency.
//

import Foundation
import InventoryDomain

public enum StorageLocationMapper {
    public static func toDTO(_ location: StorageLocation) -> StorageLocationDTO {
        StorageLocationDTO(location: location)
    }

    public static func fromDTO(_ dto: StorageLocationDTO) -> StorageLocation {
        dto.location
    }
}

