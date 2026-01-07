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
        let loginUseCase = MockLoginUseCase()
        let requestOTPUseCase = MockRequestOTPUseCase()
        return LoginViewModel(
            loginUseCase: loginUseCase,
            requestOTPUseCase: requestOTPUseCase
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

// MARK: - Mock Login Use Case

private struct MockLoginUseCase: LoginUseCaseProviding {
    func execute(with credential: LoginCredential) async throws -> AuthenticationResult {
        // Simulate network delay
        try await Task.sleep(for: .seconds(1))
        
        let user = AuthUser(id: UUID().uuidString)
        
        let authCredential: AuthCredential
        switch credential {
        case .emailPassword(let email, _):
            authCredential = .emailPassword(email: email, password: "")
        case .emailOTP(let email, _):
            authCredential = .emailOTP(email: email, otp: "")
        case .mobileOTP(let phone, let code, _):
            authCredential = .mobileOTP(phoneNumber: phone, otp: "")
        case .social(let provider):
            switch provider {
            case .google:
                authCredential = .google(idToken: "", accessToken: "")
            case .apple:
                authCredential = .apple(token: "", nonce: "")
            }
        case .anonymous:
            authCredential = .anonymous
        }
        
        return AuthenticationResult(
            user: user,
            credential: authCredential,
            isNewUser: false
        )
    }
    
    func availableLoginMethods() -> [AuthProviderType] {
        AuthProviderType.availableCases()
    }
    
    func isLoginMethodAvailable(_ providerType: AuthProviderType) -> Bool {
        true
    }
}

private struct MockRequestOTPUseCase: RequestOTPUseCaseProviding {
    func execute(with request: OTPRequest) async throws -> OTPRequestResult {
        // Simulate network delay
        try await Task.sleep(for: .seconds(1))
        
        return OTPRequestResult(
            verificationId: UUID().uuidString,
            expiresAt: Date().addingTimeInterval(300)
        )
    }
}

#endif
