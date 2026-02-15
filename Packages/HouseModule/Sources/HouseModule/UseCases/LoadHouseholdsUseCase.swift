//
//  LoadHouseholdsUseCase.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Loads households according to a caller-selected load policy.
//

import Foundation

public struct LoadHouseholdsUseCase: Sendable {
    private let repository: HouseholdRepository
    
    public init(repository: HouseholdRepository) {
        self.repository = repository
    }
    
    public func execute(
        ids: [String],
        policy: HouseLoadPolicy
    ) async throws -> [Household] {
        try await repository.loadHouseholds(ids: ids, policy: policy)
    }
}
