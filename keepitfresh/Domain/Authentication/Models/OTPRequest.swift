//
//  OTPRequest.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Request to send OTP to user
enum OTPRequest: Sendable {
    case email(email: String)
    case mobile(phoneNumber: String, countryCode: String)
}

/// Result of OTP request
struct OTPRequestResult: Sendable {
    let verificationId: String
    let expiresAt: Date
}
