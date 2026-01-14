//
//  AppDependencyContainer.swift
//  keepitfresh
//
//  Created by Codex on 11/11/24.
//

import Foundation

protocol DependencyContainer {
    func appLaunchUseCase() -> AppLaunchUseCase
    @MainActor func makeLoginViewModel() -> LoginViewModel
}

struct AppDependencyContainer: DependencyContainer {
    
    func appLaunchUseCase() -> AppLaunchUseCase {
        let metadataProvider: any AppMetadataProviding = AppMetadataService()
        let versionCheckProvider: any VersionCheckProviding = VersionCheckProvider()
        let userProvider: any UserProviding = DefaultUserProvider()
        let profileProvider: any ProfileProviding = DefaultUserProfileProvider()
        
        return AppLaunchUseCase(
            metadataProvider: metadataProvider,
            versionCheckProvider: versionCheckProvider,
            userProvider: userProvider,
            profileProvider: profileProvider
        )
    }
    
    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        let profileProvider = DefaultUserProfileProvider()
        let useCase = LoginUseCase(profileProvider: profileProvider)
        
        return LoginViewModel(useCase: useCase)
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
struct DefaultUserProfileProvider: ProfileProviding {
    func create(profile: Profile) async throws {
        
    }

    func update(profile: Profile) async throws {
        
    }

    func delete(userId: String) async throws {
        
    }

    func getProfile(for userId: String) async throws -> Profile? {
        // TODO: Implement actual profile fetch
        // For now, throw to indicate unimplemented
        struct NotImplemented: Error {}
        throw NotImplemented()
    }
}
