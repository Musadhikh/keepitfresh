//
//  InventoryItemStatus.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines lifecycle states for inventory batch instances.
//

import Foundation

public enum InventoryItemStatus: String, Sendable, Codable, Equatable, Hashable {
    case active
    case consumed
    case discarded
    case archived
}
