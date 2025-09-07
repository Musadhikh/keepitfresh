//
//  AppleAuthProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol AppleAuthProviding: AuthProviding {
    /// Request Apple Sign-In with specified scopes
    func requestAuthorization(scopes: [String]) async throws -> AuthCredential
}
