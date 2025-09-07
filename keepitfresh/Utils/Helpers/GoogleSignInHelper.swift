//
//  GoogleSignInHelper.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import GoogleSignIn
import UIKit

@MainActor
struct GoogleSignInHelper {
    
    /// Sign in with Google and return authentication credential
    static func signIn() async throws -> AuthCredential {
        guard let presentingViewController = await getRootViewController() else {
            throw AuthError.unknownError("No presenting view controller available")
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
                if let error = error {
                    continuation.resume(throwing: mapGoogleSignInError(error))
                    return
                }
                
                guard let result = result,
                      let idToken = result.user.idToken?.tokenString else {
                    continuation.resume(throwing: AuthError.invalidCredentials)
                    return
                }
                
                let accessToken = result.user.accessToken.tokenString
                let credential = AuthCredential.google(idToken: idToken, accessToken: accessToken)
                continuation.resume(returning: credential)
            }
        }
    }
    
    /// Check if user is currently signed in with Google
    static var isSignedIn: Bool {
        return GIDSignIn.sharedInstance.currentUser != nil
    }
    
    /// Sign out from Google
    static func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    // MARK: - Private Helper Methods
    
    private static func getRootViewController() async -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.windows.first else {
            return nil
        }
        return window.rootViewController
    }
    
    private static func mapGoogleSignInError(_ error: Error) -> AuthError {
        guard let gidError = error as? GIDSignInError else {
            return AuthError.unknownError(error.localizedDescription)
        }
        
        switch gidError.code {
        case .canceled:
            return AuthError.userCancel
        case .EMM:
            return AuthError.accountDisabled
        case .mismatchWithCurrentUser, .hasNoAuthInKeychain:
            return AuthError.invalidCredentials
        case .unknown,.keychain, .scopesAlreadyGranted:
            return AuthError.unknownError(gidError.localizedDescription)
        @unknown default:
            return AuthError.unknownError(gidError.localizedDescription)
        }
    }
}

#if DEBUG
extension GoogleSignInHelper {
    /// Mock sign-in for testing and previews
    static func mockSignIn() async throws -> AuthCredential {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        return AuthCredential.google(
            idToken: "mock_id_token_\(UUID().uuidString)",
            accessToken: "mock_access_token_\(UUID().uuidString)"
        )
    }
}
#endif
