//
//  AppLaunchUseCase.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct AppLaunchUseCase {
    
    let metadataProvider: any AppMetadataProviding
    let versionCheckProvider: any VersionCheckProviding
    let userProvider: any UserProviding
    let profileProvider: any UserProfileProviding
    
    func execute() async throws -> AppLaunchState {
        /// 1. Refresh app metadata
        let metadata = try await metadataProvider.getAppMetadata()
        
        /// 2. Check for maintenance
        if metadata.isUnderMaintenance {
            return AppLaunchState.maintenance
        }
        /// 3. Check for App Version update
        if versionCheckProvider.requiresVersionUpdate(metadata: metadata) {
            return AppLaunchState.updateRequired
        }
        
        /// 4. Check is user logged in
        guard let user = try await userProvider.current() else {
            return AppLaunchState.loginRequired
        }
        /// 5. Refresh user session
        try await userProvider.validateSession()
        
        /// 6. Refresh and get Profile
        let profile = try await profileProvider.getUserProfile(for: user.id)
        
        /// 7. Check if has valid house holds and last selected house hold
        if profile.householdIds.isEmpty {
            return AppLaunchState.createHousehold
        }
        
        if profile.lastSelectedHouseholdId == nil {
            return AppLaunchState.selectHousehold
        }
        
        return .mainContent
    }
}
