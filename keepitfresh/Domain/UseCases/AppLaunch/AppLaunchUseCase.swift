//
//  AppLaunchUseCase.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//  Summary: Resolves app launch routing using offline-first profile data and background sync.
//

import Foundation
import Factory
import HouseModule

struct AppLaunchUseCase: Sendable {
    
    @Injected(\.appMetadataProvider) var metadataProvider
    @Injected(\.versionCheckProvider) var versionCheckProvider
    @Injected(\.userProvider) var userProvider
    @Injected(\.profileSyncRepository) var profileSyncRepository
    @Injected(\.houseDomainModule) private var houseDomainModule
    
    func execute() async throws -> AppLaunchDecision {
        /// 1. Refresh app metadata
        let metadata = try await metadataProvider.getAppMetadata()
        /// 2. Check for maintenance
        if metadata.isUnderMaintenance {
            return AppLaunchDecision(state: .maintenance, profile: nil, selectedHouse: nil)
        }
        /// 3. Check for App Version update
        if versionCheckProvider.requiresVersionUpdate(metadata: metadata) {
            return AppLaunchDecision(state: .updateRequired, profile: nil, selectedHouse: nil)
        }
        
        /// 4. Check is user logged in
        guard let user = try await userProvider.current() else {
            return AppLaunchDecision(state: .loginRequired, profile: nil, selectedHouse: nil)
        }

        /// 5. Offline-first local profile resolution (create remote profile only when needed)
        let profile = try await profileSyncRepository.ensureProfile(for: user)

        /// 6. Background sync continues after launch routing
        await profileSyncRepository.synchronizeInBackground(for: user)

        /// 7. Route authenticated users using local profile availability.
        if profile.householdIds.isEmpty {
            return AppLaunchDecision(state: .createHousehold, profile: profile, selectedHouse: nil)
        }

        if let selectedHouse = try await resolveSelectedHouse(from: profile) {
            return AppLaunchDecision(state: .mainContent, profile: profile, selectedHouse: selectedHouse)
        }

        return AppLaunchDecision(state: .selectHousehold, profile: profile, selectedHouse: nil)
    }
}

private extension AppLaunchUseCase {
    func resolveSelectedHouse(from profile: Profile) async throws -> House? {
        guard let lastSelectedHouseID = profile.lastSelectedHouseholdId,
              profile.householdIds.contains(lastSelectedHouseID) else {
            return nil
        }

        guard let household = try await houseDomainModule.loadHouseholds.execute(
            id: lastSelectedHouseID,
            policy: .localFirst
        ) else {
            return nil
        }

        return House(moduleHousehold: household)
    }
}
