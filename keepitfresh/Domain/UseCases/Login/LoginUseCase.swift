//
//  LoginUseCase.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation
import Factory

/// Use case for handling provider authentication and post-auth profile bootstrap.
struct LoginUseCase: Sendable {
    @Injected(\.profileProvider) private var profileProvider: ProfileProviding
    
    /// 1) Authenticate with selected provider
    /// 2) Ensure profile exists (create if needed)
    /// 3) Return next app state for navigation handoff
    func login(with provider: any AuthProviding) async throws -> AppLaunchState {
        let user = try await provider.signIn()
        let profile = try await ensureProfile(for: user)
        return nextState(for: profile)
    }
    
    private func ensureProfile(for user: User) async throws -> Profile {
        if let existingProfile = try await profileProvider.getProfile(for: user.id) {
            let refreshedProfile = Profile(
                id: existingProfile.id,
                userId: existingProfile.userId,
                name: user.name,
                email: user.email,
                avatarURL: user.profileImageURL,
                householdIds: existingProfile.householdIds,
                lastSelectedHouseholdId: existingProfile.lastSelectedHouseholdId,
                isActive: existingProfile.isActive,
                createdAt: existingProfile.createdAt,
                updatedAt: Date()
            )
            try await profileProvider.update(profile: refreshedProfile)
            return refreshedProfile
        }
        
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
            updatedAt: Date()
        )
        try await profileProvider.create(profile: profile)
        return profile
    }
    
    private func nextState(for profile: Profile) -> AppLaunchState {
        if profile.householdIds.isEmpty {
            return .createHousehold
        }
        return .selectHousehold
    }
}
