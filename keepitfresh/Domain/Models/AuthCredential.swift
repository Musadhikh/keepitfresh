//
//  AuthCredential.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

/// Represents different authentication credentials for various login methods
enum AuthCredential: Sendable {
    case google(idToken: String, accessToken: String)
    case apple(token: String, nonce: String)
    case emailPassword(email: String, password: String)
    case emailOTP(email: String, otp: String)
    case mobileOTP(phoneNumber: String, otp: String)
    case anonymous
}

/// Identifies the type of authentication provider
enum AuthProviderType: String, CaseIterable, Sendable {
    case google = "google"
    case apple = "apple"
    case emailPassword = "email_password"
    case emailOTP = "email_otp"
    case mobileOTP = "mobile_otp"
    case anonymous = "anonymous"
    
    static func availableCases() -> [AuthProviderType] {
        [.google, .apple, .anonymous]
    }
}
