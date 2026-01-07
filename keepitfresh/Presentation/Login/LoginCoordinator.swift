//
//  LoginCoordinator.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Coordinates navigation in the login flow
@MainActor
protocol LoginCoordinatorProviding {
    /// Navigate to specific login method screen
    /// - Parameter method: The login method to show
    func showLoginMethod(_ method: LoginMethod)
    
    /// Navigate to OTP verification screen
    /// - Parameter state: OTP view state
    func showOTPVerification(state: OTPViewState)
    
    /// Handle successful authentication
    /// - Parameter result: Authentication result
    func handleAuthenticationSuccess(result: AuthenticationResult)
    
    /// Navigate back
    func navigateBack()
    
    /// Dismiss login flow
    func dismiss()
}
