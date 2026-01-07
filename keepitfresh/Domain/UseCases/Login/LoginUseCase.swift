//
//  LoginUseCase.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Use case for handling user login flows
protocol LoginUseCaseProviding: Sendable {
    /// Execute login with provided credentials
    /// - Parameter credential: The login credential
    /// - Returns: Authentication result
    /// - Throws: AuthError if login fails
    func execute(with credential: LoginCredential) async throws -> AuthenticationResult
    
    /// Get available login methods
    /// - Returns: Array of available authentication providers
    func availableLoginMethods() -> [AuthProviderType]
    
    /// Check if a specific login method is available
    /// - Parameter providerType: The provider type to check
    /// - Returns: True if available, false otherwise
    func isLoginMethodAvailable(_ providerType: AuthProviderType) -> Bool
}

/// Implementation of login use case
struct LoginUseCase: LoginUseCaseProviding {
    private let authCoordinator: any AuthenticationCoordinatorProviding
    
    init(authCoordinator: any AuthenticationCoordinatorProviding) {
        self.authCoordinator = authCoordinator
    }
    
    func execute(with credential: LoginCredential) async throws -> AuthenticationResult {
        // Use case can add additional business logic here
        // For example: logging, analytics, validation, etc.
        return try await authCoordinator.authenticate(with: credential)
    }
    
    func availableLoginMethods() -> [AuthProviderType] {
        return authCoordinator.availableProviders()
    }
    
    func isLoginMethodAvailable(_ providerType: AuthProviderType) -> Bool {
        return authCoordinator.availableProviders().contains(providerType)
    }
}
