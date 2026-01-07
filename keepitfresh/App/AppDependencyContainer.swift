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
        let profileProvider: any UserProfileProviding = DefaultUserProfileProvider()
        
        return AppLaunchUseCase(
            metadataProvider: metadataProvider,
            versionCheckProvider: versionCheckProvider,
            userProvider: userProvider,
            profileProvider: profileProvider
        )
    }
    
    @MainActor
    func makeLoginViewModel() -> LoginViewModel {
        // TODO: Implement actual authentication strategies
        // For now, use temporary placeholder implementations
        let authCoordinator = TemporaryAuthCoordinator()
        let loginUseCase = LoginUseCase(authCoordinator: authCoordinator)
        let requestOTPUseCase = TemporaryRequestOTPUseCase()
        
        return LoginViewModel(
            loginUseCase: loginUseCase,
            requestOTPUseCase: requestOTPUseCase
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

// MARK: - Temporary Authentication Implementations

// TODO: Replace with actual implementations
private struct TemporaryAuthCoordinator: AuthenticationCoordinatorProviding {
    private var strategies: [AuthProviderType: any AuthenticationStrategyProviding] = [:]
    
    func register(strategy: any AuthenticationStrategyProviding) {
        // Not implemented for temporary
    }
    
    func availableProviders() -> [AuthProviderType] {
        // Return all for demonstration
        return [.apple, .google, .anonymous]
    }
    
    func authenticate(with credential: LoginCredential) async throws -> AuthenticationResult {
        // TODO: Implement actual authentication
        struct NotImplemented: Error {}
        throw NotImplemented()
    }
    
    var currentUser: AuthUser? {
        get async {
            return nil
        }
    }
    
    func signOut() async throws {
        // TODO: Implement actual sign out
    }
}

private struct TemporaryRequestOTPUseCase: RequestOTPUseCaseProviding {
    func execute(with request: OTPRequest) async throws -> OTPRequestResult {
        // TODO: Implement actual OTP request
        struct NotImplemented: Error {}
        throw NotImplemented()
    }
}
