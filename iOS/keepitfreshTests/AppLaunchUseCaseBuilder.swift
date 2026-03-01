// TestSupport/AppLaunchUseCaseBuilder.swift
// Target: keepitfreshTests

import Foundation
@testable import keepitfresh

struct AppLaunchUseCaseBuilder {
    var metadata: Result<AppMetadata, TestError> = .success(Fixtures.metadataOK)
    var requiresUpdate: Bool = false
    var user: Result<keepitfresh.User?, TestError> = .success(nil)
    var validate: Result<Void, TestError> = .success(())
    var profile: Result<UserProfile, TestError> = .success(Fixtures.profile(households: [], lastSelected: nil))
    
    func build() -> AppLaunchUseCase {
        AppLaunchUseCase(
            metadataProvider: AppMetadataProviderStub(result: metadata),
            versionCheckProvider: VersionCheckProviderStub(requiresUpdate: requiresUpdate),
            userProvider: UserProviderStub(currentResult: user, validateResult: validate),
            profileProvider: UserProfileProviderStub(result: profile)
        )
    }
}
