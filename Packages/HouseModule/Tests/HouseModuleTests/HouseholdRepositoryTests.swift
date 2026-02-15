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
                description: "Primary home",
                ownerId: "u1",
                memberIds: ["u1"],
                createdAt: Date(timeIntervalSince1970: 90),
                updatedAt: Date(timeIntervalSince1970: 100),
                syncState: .synced
            )
        ]
        let storage = StorageStub(seed: [])
        let network = NetworkStub(households: expected, shouldThrow: false)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let households = try await repository.loadHouseholds(ids: ["h1"], policy: .remoteFirst)
        let cached = try await storage.fetchHouseholds(ids: ["h1"])
        
        XCTAssertEqual(households, expected)
        XCTAssertEqual(cached, expected)
    }
    
    func test_remoteFirst_fallsBackToLocalWhenNetworkFails() async throws {
        let local = [
            Household(
                id: "h-local",
                name: "Offline Home",
                description: nil,
                ownerId: "u1",
                memberIds: ["u1"],
                createdAt: Date(timeIntervalSince1970: 190),
                updatedAt: Date(timeIntervalSince1970: 200),
                syncState: .synced
            )
        ]
        let storage = StorageStub(seed: local)
        let network = NetworkStub(households: [], shouldThrow: true)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let households = try await repository.loadHouseholds(ids: ["h-local"], policy: .remoteFirst)
        
        XCTAssertEqual(households, local)
    }
    
    func test_createHousehold_persistsSyncedResultToStorage() async throws {
        let storage = StorageStub(seed: [])
        let network = NetworkStub(households: [], shouldThrow: false)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        let created = try await repository.createHousehold(
            CreateHouseholdRequest(
                name: "Fresh Home",
                description: "Kitchen and pantry",
                ownerId: "u1",
                memberIds: ["u1"]
            )
        )
        let cached = try await storage.fetchHouseholds(ids: [created.id])
        
        XCTAssertEqual(created.name, "Fresh Home")
        XCTAssertEqual(created.syncState, .synced)
        XCTAssertEqual(cached.count, 1)
        XCTAssertEqual(cached.first?.id, created.id)
    }
    
    func test_createHousehold_marksFailedOnRemoteError() async throws {
        let storage = StorageStub(seed: [])
        let network = NetworkStub(households: [], shouldThrow: true)
        let repository = HouseholdRepository(
            storageService: storage,
            networkService: network
        )
        
        do {
            _ = try await repository.createHousehold(
                CreateHouseholdRequest(
                    name: "Broken House",
                    description: nil,
                    ownerId: "u1",
                    memberIds: ["u1"]
                )
            )
            XCTFail("Expected createHousehold to throw")
        } catch {
            let stored = try await storage.fetchHouseholds(ids: [])
            XCTAssertEqual(stored.count, 1)
            XCTAssertEqual(stored.first?.syncState, .failed)
        }
    }
}

private actor StorageStub: HouseStorageServicing {
    private var households: [Household]
    
    init(seed: [Household]) {
        self.households = seed
    }
    
    func fetchHouseholds(ids: [String]) async throws -> [Household] {
        if ids.isEmpty {
            return households
        }
        let byID = Dictionary(uniqueKeysWithValues: households.map { ($0.id, $0) })
        return ids.compactMap { byID[$0] }
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
    
    func fetchHouseholds(ids: [String]) async throws -> [Household] {
        if shouldThrow {
            throw HouseModuleError.networkUnavailable
        }
        if ids.isEmpty {
            return households
        }
        let byID = Dictionary(uniqueKeysWithValues: households.map { ($0.id, $0) })
        return ids.compactMap { byID[$0] }
    }
    
    func createHousehold(_ request: CreateHouseholdRequest) async throws -> Household {
        if shouldThrow {
            throw HouseModuleError.networkUnavailable
        }
        let created = Household(
            id: UUID().uuidString,
            name: request.name,
            description: request.description,
            ownerId: request.ownerId,
            memberIds: request.memberIds,
            createdAt: Date(),
            updatedAt: Date(),
            syncState: .synced
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
