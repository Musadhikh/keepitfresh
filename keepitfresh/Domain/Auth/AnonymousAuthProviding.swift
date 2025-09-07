//
//  AnonymousAuthProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol AnonymousAuthProviding: AuthProviding {
    /// Sign in anonymously
    func signInAnonymously() async throws -> AuthCredential
}
