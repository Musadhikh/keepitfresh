//
//  AppLaunchUseCase.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct AppLaunchUseCase: Sendable {
    
    let metadataProvider: any AppMetadataProviding
    let versionCheckProvider: any VersionCheckProviding
    let userProvider: any UserProviding
    let profileProvider: any ProfileProviding
    
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
        /// 5. Refresh user session
        try await userProvider.validateSession()
        /// 6. Refresh and get Profile
        guard let profile = try await profileProvider.getProfile(for: user.id) else { return .loginRequired }
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
