//
//  CreateHouseholdUseCase.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Creates a household through network and caches the result in storage.
//

import Foundation

public struct CreateHouseholdUseCase: Sendable {
    private let repository: HouseholdRepository
    
    public init(repository: HouseholdRepository) {
        self.repository = repository
    }
    
    public func execute(name: String) async throws -> Household {
        try await repository.createHousehold(name: name)
    }
}

