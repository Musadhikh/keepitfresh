//
//  CreateHouseholdUseCase.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 20/1/26.
//

import Foundation
import Factory

struct CreateHouseholdUseCase {
    @Injected(\.userProvider) var userProvider
    
    
    func create(name: String) async throws {
        /// 1. Get user
        /// 2. Create house object
        /// 3. Create house
        /// 4. Update user with house id
        guard let user = try await userProvider.current() else { return }
        
        let house = House(
            id: UUID().uuidString,
            name: name,
            description: nil,
            memberIds: [user.id],
            adminUsers: [user.id],
            createdBy: user.id,
            createdAt: Date(),
            updatedAt: nil
        )
    }
}
