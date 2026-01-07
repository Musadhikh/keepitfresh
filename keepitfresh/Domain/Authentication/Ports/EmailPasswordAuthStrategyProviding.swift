//
//  EmailPasswordAuthStrategyProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Protocol for email and password authentication
protocol EmailPasswordAuthStrategyProviding: AuthenticationStrategyProviding {
    /// Sign in with email and password
    /// - Parameters:
    ///   - email: User's email address
    ///   - password: User's password
    /// - Returns: Authentication result
    /// - Throws: AuthError if authentication fails
    func signIn(email: String, password: String) async throws -> AuthenticationResult
    
    /// Create a new account with email and password
    /// - Parameters:
    ///   - email: User's email address
    ///   - password: User's password
    /// - Returns: Authentication result with new user
    /// - Throws: AuthError if signup fails
    func signUp(email: String, password: String) async throws -> AuthenticationResult
    
    /// Send password reset email
    /// - Parameter email: User's email address
    /// - Throws: AuthError if request fails
    func sendPasswordResetEmail(to email: String) async throws
}
