//
//  AppDependencyContainer.swift
//  keepitfresh
//
//  Created by Codex on 11/11/24.
//

import Foundation

protocol DependencyContainer {
    func appLaunchUseCase() -> AppLaunchUseCase
}

struct AppDependencyContainer: DependencyContainer {
    
    func appLaunchUseCase() -> AppLaunchUseCase {
        let metadataProvider: any AppMetadataProviding = AppMetadataService()
        let versionCheckProvider: any VersionCheckProviding = VersionCheckProvider()
        let userProvider: any UserProviding = DefaultUserProvider()
        let profileProvider: any UserProfileProviding = DefaultUserProfileProvider()
        
        return AppLaunchUseCase(
            metadataProvider: metadataProvider,
            versionCheckProvider: versionCheckProvider,
            userProvider: userProvider,
            profileProvider: profileProvider
        )
    }
}

// Temporary only
struct DefaultUserProvider: UserProviding {
    func current() async throws -> User? {
        // TODO: Implement actual current user fetch (e.g., from auth/session)
        return nil
    }
    
    func validateSession() async throws {
        // TODO: Implement actual session validation/refresh
    }
}

// Temporary only
struct DefaultUserProfileProvider: UserProfileProviding {
    func getUserProfile(for userId: String) async throws -> UserProfile {
        // TODO: Implement actual profile fetch
        // For now, throw to indicate unimplemented
        struct NotImplemented: Error {}
        throw NotImplemented()
    }
}
