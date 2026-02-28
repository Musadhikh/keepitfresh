//
//  InventoryRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares remote inventory mutation operations used by offline-first sync flows.
//

import Foundation

public protocol InventoryRemoteGateway: Sendable {
    func upsert(_ items: [InventoryItem]) async throws
    func fetchActiveItems(householdId: String) async throws -> [InventoryItem]
}
