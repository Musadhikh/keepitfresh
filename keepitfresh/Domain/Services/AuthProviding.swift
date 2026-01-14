//
//  AuthProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol AuthProviding: Sendable {
    /// Execute the authentication flow and return credentials
    func signIn() async throws -> User
}
