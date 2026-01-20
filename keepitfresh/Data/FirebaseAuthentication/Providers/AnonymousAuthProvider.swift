//
//  AnonymousAuthProvider.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import FirebaseAuth

actor AnonymousAuthProvider: AuthProviding {
    func signIn() async throws -> User {
        let authResult = try await Auth.auth().signInAnonymously()
        
        return User(
            id: authResult.user.uid,
            name: authResult.user.displayName ?? "UnKnown",
            email: authResult.user.email,
            profileImageURL: authResult.user.photoURL?.absoluteString,
            lastLoggedIn: Date()
        )
    }
    
    func signOut() async throws {}
    
    func deleteAccount() async throws {
        
    }
}
