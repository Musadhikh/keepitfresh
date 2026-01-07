//
//  SocialAuthStrategyProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Protocol for social authentication strategies (Google, Apple, etc.)
protocol SocialAuthStrategyProviding: AuthenticationStrategyProviding {
    /// The social provider this strategy handles
    var socialProvider: SocialAuthProvider { get }
    
    /// Initiate social authentication flow
    /// - Returns: Authentication result
    /// - Throws: AuthError if authentication fails or is cancelled
    func signIn() async throws -> AuthenticationResult
    
    /// Check if social authentication is available on this device
    var isAvailable: Bool { get }
}
