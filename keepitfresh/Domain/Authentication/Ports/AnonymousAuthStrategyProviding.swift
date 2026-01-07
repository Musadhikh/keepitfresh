//
//  AnonymousAuthStrategyProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Protocol for anonymous authentication
protocol AnonymousAuthStrategyProviding: AuthenticationStrategyProviding {
    /// Sign in anonymously
    /// - Returns: Authentication result with anonymous user
    /// - Throws: AuthError if authentication fails
    func signInAnonymously() async throws -> AuthenticationResult
}
