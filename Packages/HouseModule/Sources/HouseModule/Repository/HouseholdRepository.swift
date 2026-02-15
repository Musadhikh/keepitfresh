//
//  HouseholdRepository.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Coordinates storage and network operations for household data using constructor injection.
//

import Foundation

public actor HouseholdRepository {
    private let storageService: any HouseStorageServicing
    private let networkService: any HouseNetworkServicing
    
    public init(
        storageService: any HouseStorageServicing,
        networkService: any HouseNetworkServicing
    ) {
        self.storageService = storageService
        self.networkService = networkService
    }
    
    public func loadHouseholds(policy: HouseLoadPolicy) async throws -> [Household] {
        switch policy {
        case .localOnly:
            return try await storageService.fetchHouseholds()
        case .remoteOnly:
            let remote = try await networkService.fetchHouseholds()
            try await storageService.saveHouseholds(remote)
            return remote
        case .localFirst:
            let local = try await storageService.fetchHouseholds()
            if local.isEmpty {
                let remote = try await networkService.fetchHouseholds()
                try await storageService.saveHouseholds(remote)
                return remote
            }
            return local
        case .remoteFirst:
            do {
                let remote = try await networkService.fetchHouseholds()
                try await storageService.saveHouseholds(remote)
                return remote
            } catch {
                return try await storageService.fetchHouseholds()
            }
        }
    }
    
    public func syncHouseholds() async throws -> [Household] {
        let households = try await networkService.fetchHouseholds()
        try await storageService.saveHouseholds(households)
        return households
    }
    
    public func createHousehold(name: String) async throws -> Household {
        let household = try await networkService.createHousehold(name: name)
        try await storageService.upsertHousehold(household)
        return household
    }
    
    public func updateHousehold(_ household: Household) async throws -> Household {
        let updated = try await networkService.updateHousehold(household)
        try await storageService.upsertHousehold(updated)
        return updated
    }
    
    public func deleteHousehold(id: String) async throws {
        try await networkService.deleteHousehold(id: id)
        try await storageService.deleteHousehold(id: id)
    }
}

