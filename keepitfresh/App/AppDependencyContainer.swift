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
        let userProvider: any UserProviding = UserFirebaseService()
        let profileProvider: any ProfileProviding = ProfileFirebaseService()
        
        return AppLaunchUseCase(
            metadataProvider: metadataProvider,
            versionCheckProvider: versionCheckProvider,
            userProvider: userProvider,
            profileProvider: profileProvider
        )
    }
    
    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        let profileProvider = ProfileFirebaseService()
        let useCase = LoginUseCase(profileProvider: profileProvider)
        
        return LoginViewModel(useCase: useCase)
    }
}
