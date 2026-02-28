//
//  StorageLocationDTO.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines transfer representation of storage locations for persistence adapters.
//

import Foundation
import InventoryDomain

public struct StorageLocationDTO: Sendable, Codable, Equatable, Hashable {
    public var location: StorageLocation

    public init(location: StorageLocation) {
        self.location = location
    }
}

