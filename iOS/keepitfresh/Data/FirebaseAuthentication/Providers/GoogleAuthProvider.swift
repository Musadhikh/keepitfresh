//
//  GoogleAuthProvider.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import Firebase
import FirebaseAuth
import GoogleSignIn

enum GoogleAuthError: LocalizedError {
    case missingClientID
    case missingViewController
    case missingIDToken
    case userCancelled
}

actor GoogleSignInProvider: AuthProviding {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    @MainActor
    func signIn() async throws -> User {
        do {
            guard let clientId = FirebaseApp.app()?.options.clientID else { throw GoogleAuthError.missingClientID }
            
            let config = GIDConfiguration(clientID: clientId)
            GIDSignIn.sharedInstance.configuration = config
            
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
            
            guard let idToken = result.user.idToken?.tokenString else { throw GoogleAuthError.missingIDToken }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            let authResult = try await Auth.auth().signIn(with: credential)
            
            return User(
                id: authResult.user.uid,
                name: authResult.user.displayName ?? "UnKnown",
                email: authResult.user.email,
                profileImageURL: authResult.user.photoURL?.absoluteString,
                lastLoggedIn: Date()
            )
        } catch {
            if error.errorCode == GIDSignInError.canceled.rawValue {
                throw GoogleAuthError.userCancelled
            } else {
                throw error
            }
        }
    }
    
    func signOut() async throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        
    }
}
