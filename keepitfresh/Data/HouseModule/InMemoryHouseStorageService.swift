//
//  InMemoryHouseStorageService.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Provides a mock in-memory household database for HouseModule storage operations.
//

import Foundation
import HouseModule

actor InMemoryHouseStorageService: HouseStorageServicing {
    private var householdsByID: [String: Household] = [:]
    
    func fetchHouseholds(ids: [String]) async throws -> [Household] {
        if ids.isEmpty {
            return householdsByID.values.sorted {
                $0.updatedAt < $1.updatedAt
            }
        }
        return ids.compactMap { householdsByID[$0] }
    }
    
    func upsertHousehold(_ household: Household) async throws {
        householdsByID[household.id] = household
    }
    
    func deleteHousehold(id: String) async throws {
        householdsByID[id] = nil
    }
}
