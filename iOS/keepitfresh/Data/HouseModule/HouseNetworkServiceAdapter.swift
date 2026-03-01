//
//  HouseNetworkServiceAdapter.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Adapts app-level house provider operations to HouseModule network service contracts.
//

import Foundation
import HouseModule

actor HouseNetworkServiceAdapter: HouseNetworkServicing {
    private let houseProvider: any HouseProviding
    
    init(houseProvider: any HouseProviding) {
        self.houseProvider = houseProvider
    }
    
    func fetchHousehold(id: String) async throws -> Household? {
        guard let house = try await houseProvider.getHouse(for: id) else { return nil }
        return Household(
            id: house.id,
            name: house.name,
            description: house.description,
            ownerId: house.ownerId,
            memberIds: house.memberIds,
            createdAt: house.createdAt,
            updatedAt: house.updatedAt ?? house.createdAt,
            syncState: .synced
        )
    }
    
    func fetchHouseholds(ids: [String]) async throws -> [Household] {
        let houses = try await houseProvider.getHouses(for: ids)
        return houses.map { house in
            Household(
                id: house.id,
                name: house.name,
                description: house.description,
                ownerId: house.ownerId,
                memberIds: house.memberIds,
                createdAt: house.createdAt,
                updatedAt: house.updatedAt ?? house.createdAt,
                syncState: .synced
            )
        }
    }
    
    func createHousehold(_ request: CreateHouseholdRequest) async throws -> Household {
        let createdHouse = try await houseProvider.createHouse(
            name: request.name,
            description: request.description,
            ownerId: request.ownerId,
            memberIds: request.memberIds
        )
        return Household(
            id: createdHouse.id,
            name: createdHouse.name,
            description: createdHouse.description,
            ownerId: createdHouse.ownerId,
            memberIds: createdHouse.memberIds,
            createdAt: createdHouse.createdAt,
            updatedAt: createdHouse.updatedAt ?? createdHouse.createdAt,
            syncState: .synced
        )
    }
    
    func updateHousehold(_ household: Household) async throws -> Household {
        throw HouseNetworkServiceAdapterError.notImplemented
    }
    
    func deleteHousehold(id: String) async throws {
        throw HouseNetworkServiceAdapterError.notImplemented
    }
}

private enum HouseNetworkServiceAdapterError: LocalizedError {
    case notImplemented
    
    var errorDescription: String? {
        switch self {
        case .notImplemented:
            return "This operation is not implemented yet."
        }
    }
}
