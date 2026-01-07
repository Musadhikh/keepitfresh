//
//  OTPAuthStrategyProviding.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Protocol for OTP-based authentication (Email or Mobile)
protocol OTPAuthStrategyProviding: AuthenticationStrategyProviding {
    /// Request an OTP to be sent
    /// - Parameter request: OTP request (email or mobile)
    /// - Returns: Result containing verification ID
    /// - Throws: AuthError if request fails
    func requestOTP(for request: OTPRequest) async throws -> OTPRequestResult
    
    /// Verify OTP and authenticate
    /// - Parameters:
    ///   - verificationId: The verification ID from request
    ///   - otp: The OTP code received
    /// - Returns: Authentication result
    /// - Throws: AuthError if verification fails
    func verifyOTP(verificationId: String, otp: String) async throws -> AuthenticationResult
    
    /// Resend OTP
    /// - Parameter request: OTP request to resend
    /// - Returns: New verification result
    /// - Throws: AuthError if request fails
    func resendOTP(for request: OTPRequest) async throws -> OTPRequestResult
}
