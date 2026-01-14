//
//  UserFirebaseService.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import FirebaseAuth

struct UserFirebaseService: UserProviding {
    func current() async throws -> User? {
        if let current = Auth.auth().currentUser {
            return User(
                id: current.uid,
                name: current.displayName ?? "UnKnown",
                email: current.email,
                profileImageURL: current.photoURL?.absoluteString,
                lastLoggedIn: Date()
            )
        }
        
        return nil
    }

    func validateSession() async throws {
        
    }

    
}
