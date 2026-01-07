//
//  RequestOTPUseCase.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Use case for requesting OTP
protocol RequestOTPUseCaseProviding: Sendable {
    /// Request OTP for email or mobile
    /// - Parameter request: OTP request
    /// - Returns: OTP request result with verification ID
    /// - Throws: AuthError if request fails
    func execute(with request: OTPRequest) async throws -> OTPRequestResult
}

/// Implementation of request OTP use case
struct RequestOTPUseCase: RequestOTPUseCaseProviding {
    private let otpStrategy: any OTPAuthStrategyProviding
    
    init(otpStrategy: any OTPAuthStrategyProviding) {
        self.otpStrategy = otpStrategy
    }
    
    func execute(with request: OTPRequest) async throws -> OTPRequestResult {
        // Add validation, rate limiting logic, etc.
        return try await otpStrategy.requestOTP(for: request)
    }
}
