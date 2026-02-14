//
//  AppLaunchUseCase.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation
import Factory

struct AppLaunchUseCase: Sendable {
    
    @Injected(\.appMetadataProvider) var metadataProvider
    @Injected(\.versionCheckProvider) var versionCheckProvider
    @Injected(\.userProvider) var userProvider
    @Injected(\.profileProvider) var profileProvider
    
    func execute() async throws -> AppLaunchState {
        /// 1. Refresh app metadata
        let metadata = try await metadataProvider.getAppMetadata()
        /// 2. Check for maintenance
        if metadata.isUnderMaintenance {
            return .maintenance
        }
        /// 3. Check for App Version update
        if versionCheckProvider.requiresVersionUpdate(metadata: metadata) {
            return .updateRequired
        }
        
        /// 4. Check is user logged in
        guard let user = try await userProvider.current() else {
            return .loginRequired
        }
        
//        /// 5. Refresh user session
//        try await userProvider.validateSession()
        /// 6. Refresh and get Profile (create if missing)
        let profile: Profile
        if let existingProfile = try await profileProvider.getProfile(for: user.id) {
            profile = existingProfile
        } else {
            let createdProfile = Profile(
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
            try await profileProvider.create(profile: createdProfile)
            profile = createdProfile
        }

        /// 7. Check if has valid house holds and last selected house hold
        if profile.householdIds.isEmpty {
            return .createHousehold
        }
        
        if profile.lastSelectedHouseholdId == nil {
            return .selectHousehold
        }
        
        return .mainContent
    }
}
