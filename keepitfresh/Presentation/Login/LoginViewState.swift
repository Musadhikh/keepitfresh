//
//  LoginViewState.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Represents different login methods available
enum LoginMethod: Sendable, CaseIterable {
    case emailPassword
    case emailOTP
    case mobileOTP
    case google
    case apple
    case anonymous
    
    var title: String {
        switch self {
        case .emailPassword: return "Email & Password"
        case .emailOTP: return "Email with OTP"
        case .mobileOTP: return "Mobile with OTP"
        case .google: return "Google"
        case .apple: return "Apple"
        case .anonymous: return "Continue as Guest"
        }
    }
    
    var providerType: AuthProviderType {
        switch self {
        case .emailPassword: return .emailPassword
        case .emailOTP: return .emailOTP
        case .mobileOTP: return .mobileOTP
        case .google: return .google
        case .apple: return .apple
        case .anonymous: return .anonymous
        }
    }
}

/// State of the login flow
enum LoginFlowState: Sendable {
    case idle
    case selectingMethod
    case enteringCredentials(LoginMethod)
    case requestingOTP(OTPRequest)
    case verifyingOTP(verificationId: String, request: OTPRequest)
    case authenticating
    case success(AuthenticationResult)
    case error(AuthError)
}

/// View state for OTP flow
struct OTPViewState: Sendable {
    let verificationId: String
    let request: OTPRequest
    let expiresAt: Date
    var remainingTime: TimeInterval {
        max(0, expiresAt.timeIntervalSinceNow)
    }
    var canResend: Bool {
        remainingTime == 0
    }
}
