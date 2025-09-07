//
//  FirebaseAuthService.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import FirebaseAuth

actor FirebaseAuthService: AuthServiceProviding {
    
    // MARK: - Private Properties
    private let auth = Auth.auth()
    
    // MARK: - AuthServiceProviding Implementation
    
    var currentUser: AuthUser? {
        get async {
            auth.currentUser?.authUser
        }
    }
    
    func signInWith(provider: AuthProviding) async throws -> AuthUser {
        do {
            let credential = try await provider.execute()
            
            let user = Task.detached {
                if let firebaseCredential = credential.firebaseCredential {
                    let data = try await self.auth.signIn(with: firebaseCredential)
                    return data.user.authUser
                } else {
                    // Handle anonymous sign-in
                    let result = try await self.auth.signInAnonymously()
                    return result.user.authUser
                }
            }
            
            return try await user.value
            
        } catch let error as AuthError {
            throw error
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    func signOut() async throws {
        do {
            try auth.signOut()
        } catch {
            throw mapFirebaseError(error)
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func mapFirebaseError(_ error: Error) -> AuthError {
        guard let authError = error as NSError? else {
            return AuthError.unknownError(error.localizedDescription)
        }
        
        switch AuthErrorCode(rawValue: authError.code) {
        case .networkError:
            return AuthError.networkError
        case .userDisabled:
            return AuthError.accountDisabled
        case .invalidEmail, .wrongPassword, .userNotFound:
            return AuthError.invalidCredentials
        case .webContextCancelled:
            return AuthError.userCancel
        default:
            return AuthError.unknownError(authError.localizedDescription)
        }
    }
}
