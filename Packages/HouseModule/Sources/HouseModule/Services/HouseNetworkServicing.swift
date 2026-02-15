//
//  HouseNetworkServicing.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines the network contract required by household use cases.
//

import Foundation

public protocol HouseNetworkServicing: Sendable {
    func fetchHouseholds(ids: [String]) async throws -> [Household]
    func createHousehold(_ request: CreateHouseholdRequest) async throws -> Household
    func updateHousehold(_ household: Household) async throws -> Household
    func deleteHousehold(id: String) async throws
}
