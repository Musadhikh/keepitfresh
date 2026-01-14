//
//  LoginUseCase.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation
import Factory
/// Use case for handling user login flows
struct LoginUseCase {
    
    @Injected(\.profileProvider) var profileProvider
    /// 1. Login with provider
    /// 2. Check if user exist in the profile store
    /// 3. If user doesn't exist in profile, create profile
    /// 4. If user exists in profile, update last logged in date
    /// 5. If
    func login(with provider: any AuthProviding) async throws {
        let user = try await provider.signIn()
        
        guard let _ = try await profileProvider.getProfile(for: user.id) else {
            let profile = Profile(
                id: user.id,
                userId: user.id,
                name: user.name,
                email: user.email,
                avatarURL: user.profileImageURL,
                householdIds: [],
                lastSelectedHouseholdId: nil,
                isActive: true,
                createdAt: Date(),
                updatedAt: nil
            )
            try await profileProvider.create(profile: profile)
            return
        }
    }
}
