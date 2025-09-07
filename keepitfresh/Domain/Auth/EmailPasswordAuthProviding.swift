//
//  EmailPasswordAuthProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol EmailPasswordAuthProviding: AuthProviding {
    /// Sign in with email and password
    func signIn(email: String, password: String) async throws -> AuthCredential
    
    /// Register new user with email and password
    func register(email: String, password: String, name: String?) async throws -> AuthCredential
    
    /// Send password reset email
    func sendPasswordReset(email: String) async throws
}
