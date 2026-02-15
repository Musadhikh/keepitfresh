//
//  SyncHouseholdsUseCase.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Refreshes households from the network and persists them to storage.
//

import Foundation

public struct SyncHouseholdsUseCase: Sendable {
    private let repository: HouseholdRepository
    
    public init(repository: HouseholdRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Household] {
        try await repository.syncHouseholds()
    }
}

