//
//  LoginUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Authenticates a user, ensures local profile availability, and returns launch routing context.
//

import Foundation
import Factory
import HouseModule

/// Use case for handling provider authentication and post-auth profile bootstrap.
struct LoginUseCase: Sendable {
    @Injected(\.profileSyncRepository) private var profileSyncRepository: ProfileSyncRepository
    @Injected(\.houseDomainModule) private var houseDomainModule: HouseModule
    
    /// 1) Authenticate with selected provider
    /// 2) Ensure profile exists (create if needed)
    /// 3) Return next app state for navigation handoff
    func login(with provider: any AuthProviding) async throws -> AppLaunchDecision {
        let user = try await provider.signIn()
        let profile = try await profileSyncRepository.ensureProfile(for: user)
        await profileSyncRepository.synchronizeInBackground(for: user)
        return try await nextDecision(for: profile)
    }
    
    private func nextDecision(for profile: Profile) async throws -> AppLaunchDecision {
        if profile.householdIds.isEmpty {
            return AppLaunchDecision(state: .createHousehold, profile: profile, selectedHouse: nil)
        }

        if let selectedHouseID = profile.lastSelectedHouseholdId,
           profile.householdIds.contains(selectedHouseID),
           let selectedHousehold = try await houseDomainModule.loadHouseholds.execute(
               id: selectedHouseID,
               policy: .localFirst
           ) {
            return AppLaunchDecision(
                state: .mainContent,
                profile: profile,
                selectedHouse: House(moduleHousehold: selectedHousehold)
            )
        }

        return AppLaunchDecision(state: .selectHousehold, profile: profile, selectedHouse: nil)
    }
}
