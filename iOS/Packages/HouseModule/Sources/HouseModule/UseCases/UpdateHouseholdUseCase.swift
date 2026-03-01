//
//  UpdateHouseholdUseCase.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Updates a household through network and persists the latest representation locally.
//

import Foundation

public struct UpdateHouseholdUseCase: Sendable {
    private let repository: HouseholdRepository
    
    public init(repository: HouseholdRepository) {
        self.repository = repository
    }
    
    public func execute(_ household: Household) async throws -> Household {
        try await repository.updateHousehold(household)
    }
}

