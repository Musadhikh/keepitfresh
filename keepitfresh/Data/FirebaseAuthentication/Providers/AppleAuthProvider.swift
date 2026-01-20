//
//  AppleAuthProvider.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

enum AppleAuthError: LocalizedError {
    case missingIdToken
}

actor AppleAuthProvider: AuthProviding {
    let nonce: String?
    let authorization: ASAuthorization
    
    init(nonce: String?, authorization: ASAuthorization) {
        self.nonce = nonce
        self.authorization = authorization
    }
    
    func signIn() async throws -> User {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let idToken = credential.identityToken,
              let token = String(data: idToken, encoding: .utf8) else {
            throw AppleAuthError.missingIdToken
        }
        
        let provider = OAuthProvider.appleCredential(
            withIDToken: token,
            rawNonce: nonce,
            fullName: credential.fullName
        )
    
        let authResult = try await Auth.auth().signIn(with: provider)
        
        return User(
            id: authResult.user.uid,
            name: authResult.user.displayName ?? "UnKnown",
            email: authResult.user.email,
            profileImageURL: authResult.user.photoURL?.absoluteString,
            lastLoggedIn: Date()
        )
    }
    
    func signOut() async throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        
    }
}
