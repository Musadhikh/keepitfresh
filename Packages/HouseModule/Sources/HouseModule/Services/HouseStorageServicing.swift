//
//  HouseStorageServicing.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines the storage contract required by household use cases.
//

import Foundation

public protocol HouseStorageServicing: Sendable {
    func fetchHouseholds(ids: [String]) async throws -> [Household]
    func upsertHousehold(_ household: Household) async throws
    func deleteHousehold(id: String) async throws
}
