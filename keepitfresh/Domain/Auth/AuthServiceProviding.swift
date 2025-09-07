//
//  AuthServiceProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol AuthServiceProviding: Sendable {
    /// Current authenticated user
    var currentUser: AuthUser? { get async }
    
    /// Sign in with a specific auth provider
    func signInWith(provider: AuthProviding) async throws -> AuthUser
    
    /// Sign out the current user
    func signOut() async throws
    
    /// Observe authentication state changes
    //    func observeAuthState() -> AsyncStream<AuthUser?>
    // TODO: For future implementation
}
