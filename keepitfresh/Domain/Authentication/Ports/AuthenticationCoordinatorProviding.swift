//
//  AuthenticationCoordinatorProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Coordinates authentication across multiple strategies
/// This is the main entry point for authentication in the app
protocol AuthenticationCoordinatorProviding: Sendable {
    /// Register an authentication strategy
    /// - Parameter strategy: The strategy to register
    func register(strategy: any AuthenticationStrategyProviding)
    
    /// Get available authentication providers
    /// - Returns: Array of available provider types
    func availableProviders() -> [AuthProviderType]
    
    /// Authenticate using a specific credential
    /// - Parameter credential: The login credential
    /// - Returns: Authentication result
    /// - Throws: AuthError if authentication fails
    func authenticate(with credential: LoginCredential) async throws -> AuthenticationResult
    
    /// Get current authenticated user
    /// - Returns: Currently authenticated user, if any
    var currentUser: AuthUser? { get async }
    
    /// Sign out current user
    /// - Throws: AuthError if sign out fails
    func signOut() async throws
}
