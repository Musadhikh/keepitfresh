//
//  HouseholdRepositoryTests.swift
//  HouseModuleTests
//
//  Created by musadhikh on 15/2/26.
//  Summary: Verifies repository behavior for local/remote loading and mutation workflows.
//

import XCTest
@testable import HouseModule

final class HouseholdRepositoryTests: XCTestCase {
    func test_remoteFirst_returnsRemoteAndCachesToStorage() async throws {
        let expected = [
            Household(
                id: "h1",
                name: "Home",
                members: [],
                updatedAt: Date(timeIntervalSince1970: 100)
            )
        ]
        let storage = StorageStub(seed: [])
        let network = NetworkStub(households: expected, shouldThrow: false)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let households = try await repository.loadHouseholds(policy: .remoteFirst)
        let cached = try await storage.fetchHouseholds()
        
        XCTAssertEqual(households, expected)
        XCTAssertEqual(cached, expected)
    }
    
    func test_remoteFirst_fallsBackToLocalWhenNetworkFails() async throws {
        let local = [
            Household(
                id: "h-local",
                name: "Offline Home",
                members: [],
                updatedAt: Date(timeIntervalSince1970: 200)
            )
        ]
        let storage = StorageStub(seed: local)
        let network = NetworkStub(households: [], shouldThrow: true)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let households = try await repository.loadHouseholds(policy: .remoteFirst)
        
        XCTAssertEqual(households, local)
    }
    
    func test_createHousehold_persistsToStorage() async throws {
        let storage = StorageStub(seed: [])
        let network = NetworkStub(households: [], shouldThrow: false)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let created = try await repository.createHousehold(name: "Fresh Home")
        let cached = try await storage.fetchHouseholds()
        
        XCTAssertEqual(created.name, "Fresh Home")
        XCTAssertEqual(cached.count, 1)
        XCTAssertEqual(cached.first?.id, created.id)
    }
}

private actor StorageStub: HouseStorageServicing {
    private var households: [Household]
    
    init(seed: [Household]) {
        self.households = seed
    }
    
    func fetchHouseholds() async throws -> [Household] {
        households
    }
    
    func saveHouseholds(_ households: [Household]) async throws {
        self.households = households
    }
    
    func upsertHousehold(_ household: Household) async throws {
        households.removeAll { $0.id == household.id }
        households.append(household)
    }
    
    func deleteHousehold(id: String) async throws {
        households.removeAll { $0.id == id }
    }
}

private actor NetworkStub: HouseNetworkServicing {
    private var households: [Household]
    private let shouldThrow: Bool
    
    init(households: [Household], shouldThrow: Bool) {
        self.households = households
        self.shouldThrow = shouldThrow
    }
    
    func fetchHouseholds() async throws -> [Household] {
        if shouldThrow {
            throw HouseModuleError.networkUnavailable
        }
        return households
    }
    
    func createHousehold(name: String) async throws -> Household {
        let created = Household(
            id: UUID().uuidString,
            name: name,
            members: [],
            updatedAt: Date()
        )
        households.append(created)
        return created
    }
    
    func updateHousehold(_ household: Household) async throws -> Household {
        households.removeAll { $0.id == household.id }
        households.append(household)
        return household
    }
    
    func deleteHousehold(id: String) async throws {
        households.removeAll { $0.id == id }
    }
}
