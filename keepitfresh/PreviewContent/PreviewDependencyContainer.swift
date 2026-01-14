//
//  PreviewDependencyContainer.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation

#if DEBUG
struct PreviewDependencyContainer: DependencyContainer {
    static let shared = PreviewDependencyContainer()
    
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
    
    @MainActor func makeLoginViewModel() -> LoginViewModel {
        let profileProvider = StaticUserProfileProvider()
        let loginUseCase = LoginUseCase(profileProvider: profileProvider)
        
        return LoginViewModel(useCase: loginUseCase)
    }
}


// MARK: - Static Providers
private struct StaticAppMetadataProvider: AppMetadataProviding {
    func getAppMetadata() async throws -> AppMetadata {
        AppMetadata(
            message: "Welcome to Keep It Fresh",
            minimumVersion: "1.0.0",
            appStoreUrl: "https://example.com/app",
            isUnderMaintenance: true
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

private struct StaticUserProfileProvider: ProfileProviding {
    func create(profile: Profile) async throws {
        
    }

    func update(profile: Profile) async throws {
        
    }

    func delete(userId: String) async throws {
        
    }

    func getProfile(for userId: String) async throws -> Profile? {
        Profile(
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

// MARK: - Mock Login Use Case


#endif
