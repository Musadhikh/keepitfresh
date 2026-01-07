//
//  LoginCredential.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Input credentials provided by the user for authentication
enum LoginCredential: Sendable {
    case emailPassword(email: String, password: String)
    case emailOTP(email: String, otp: String)
    case mobileOTP(phoneNumber: String, countryCode: String, otp: String)
    case social(provider: SocialAuthProvider)
    case anonymous
}

/// Social authentication provider types
enum SocialAuthProvider: Sendable {
    case google
    case apple
    // Future providers can be added here (e.g., facebook, twitter, etc.)
}

/// Result of an authentication attempt
struct AuthenticationResult: Sendable {
    let user: AuthUser
    let credential: AuthCredential
    let isNewUser: Bool
}
