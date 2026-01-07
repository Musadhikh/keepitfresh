//
//  AuthenticationStrategyProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Base protocol for all authentication strategies
/// Each authentication method implements this protocol
protocol AuthenticationStrategyProviding: Sendable {
    /// The type of authentication this strategy handles
    var providerType: AuthProviderType { get }
    
    /// Authenticates using the provided credentials
    /// - Parameter credential: The authentication credential
    /// - Returns: The authenticated user and auth credential
    /// - Throws: AuthError if authentication fails
    func authenticate(with credential: LoginCredential) async throws -> AuthenticationResult
}
