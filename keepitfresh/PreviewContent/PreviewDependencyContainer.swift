//
//  PreviewDependencyContainer.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation

#if DEBUG
struct PreviewDependencyContainer: DependencyContainer {
    func appLaunchUseCase() -> AppLaunchUseCase {
        let metadataProvider = StaticAppMetadataProvider()
        let versionCheckProvider = StaticVersionCheckProvider()
        let userProvider = StaticUserProvider()
        let profileProvider = StaticUserProfileProvider()
        
        return AppLaunchUseCase(
            metadataProvider: metadataProvider,
            versionCheckProvider: versionCheckProvider,
            userProvider: userProvider,
            profileProvider: profileProvider
        )
    }
}


// MARK: - Static Providers
private struct StaticAppMetadataProvider: AppMetadataProviding {
    func getAppMetadata() async throws -> AppMetadata {
        AppMetadata(
            message: "Welcome to Keep It Fresh",
            minimumVersion: "1.0.0",
            appStoreUrl: "https://example.com/app",
            isUnderMaintenance: false
        )
    }
}

private struct StaticVersionCheckProvider: VersionCheckProviding {
    func requiresVersionUpdate(metadata: AppMetadata) -> Bool {
        false
    }
}

private struct StaticUserProvider: UserProviding {
    func current() async throws -> User? {
        return nil
        User(
            id: UUID().uuidString,
            name: "Sample User",
            email: "sample@keepitfresh.app",
            profileImageURL: nil,
            lastLoggedIn: Date()
        )
    }
    
    func validateSession() async throws {
        // No-op for now
    }
}

private struct StaticUserProfileProvider: UserProfileProviding {
    func getUserProfile(for userId: String) async throws -> UserProfile {
        UserProfile(
            id: "profile-\(userId)",
            userId: userId,
            name: "Sample User",
            email: "sample@keepitfresh.app",
            avatarURL: nil,
            householdIds: ["household-1"],
            lastSelectedHouseholdId: "household-1",
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}


#endif
