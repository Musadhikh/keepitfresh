//
//  DeleteHouseholdUseCase.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Deletes a household remotely and then removes it from local storage.
//

import Foundation

public struct DeleteHouseholdUseCase: Sendable {
    private let repository: HouseholdRepository
    
    public init(repository: HouseholdRepository) {
        self.repository = repository
    }
    
    public func execute(id: String) async throws {
        try await repository.deleteHousehold(id: id)
    }
}

