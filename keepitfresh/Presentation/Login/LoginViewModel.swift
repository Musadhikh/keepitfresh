//
//  LoginViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/11/25.
//

import Foundation
import Observation

@MainActor
@Observable
class LoginViewModel {
    // MARK: - Properties
    private let loginUseCase: any LoginUseCaseProviding
    private let requestOTPUseCase: any RequestOTPUseCaseProviding
    private let coordinator: (any LoginCoordinatorProviding)?
    
    var flowState: LoginFlowState = .idle
    var availableMethods: [LoginMethod] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Initialization
    init(
        loginUseCase: any LoginUseCaseProviding,
        requestOTPUseCase: any RequestOTPUseCaseProviding,
        coordinator: (any LoginCoordinatorProviding)? = nil
    ) {
        self.loginUseCase = loginUseCase
        self.requestOTPUseCase = requestOTPUseCase
        self.coordinator = coordinator
        loadAvailableMethods()
    }
    
    // MARK: - Public Methods
    
    /// Load available login methods
    func loadAvailableMethods() {
        let providers = loginUseCase.availableLoginMethods()
        availableMethods = LoginMethod.allCases.filter { method in
            providers.contains(method.providerType)
        }
    }
    
    /// Select a login method
    /// - Parameter method: The login method to use
    func selectLoginMethod(_ method: LoginMethod) {
        flowState = .enteringCredentials(method)
        coordinator?.showLoginMethod(method)
    }
    
    /// Login with email and password
    /// - Parameters:
    ///   - email: User's email
    ///   - password: User's password
    func loginWithEmailPassword(email: String, password: String) async {
        let credential = LoginCredential.emailPassword(email: email, password: password)
        await performLogin(with: credential)
    }
    
    /// Request OTP for email
    /// - Parameter email: User's email
    func requestEmailOTP(email: String) async {
        let request = OTPRequest.email(email: email)
        await requestOTP(for: request)
    }
    
    /// Request OTP for mobile
    /// - Parameters:
    ///   - phoneNumber: User's phone number
    ///   - countryCode: Country code (e.g., "+1")
    func requestMobileOTP(phoneNumber: String, countryCode: String) async {
        let request = OTPRequest.mobile(phoneNumber: phoneNumber, countryCode: countryCode)
        await requestOTP(for: request)
    }
    
    /// Verify OTP
    /// - Parameters:
    ///   - verificationId: Verification ID from OTP request
    ///   - otp: OTP code entered by user
    ///   - request: Original OTP request
    func verifyOTP(verificationId: String, otp: String, request: OTPRequest) async {
        let credential: LoginCredential
        switch request {
        case .email(let email):
            credential = .emailOTP(email: email, otp: otp)
        case .mobile(let phoneNumber, let countryCode):
            credential = .mobileOTP(phoneNumber: phoneNumber, countryCode: countryCode, otp: otp)
        }
        await performLogin(with: credential)
    }
    
    /// Login with social provider
    /// - Parameter provider: Social auth provider
    func loginWithSocial(provider: SocialAuthProvider) async {
        let credential = LoginCredential.social(provider: provider)
        await performLogin(with: credential)
    }
    
    /// Continue as guest (anonymous)
    func continueAsGuest() async {
        let credential = LoginCredential.anonymous
        await performLogin(with: credential)
    }
    
    /// Resend OTP
    /// - Parameter request: OTP request to resend
    func resendOTP(for request: OTPRequest) async {
        await requestOTP(for: request)
    }
    
    // MARK: - Private Methods
    
    private func performLogin(with credential: LoginCredential) async {
        isLoading = true
        flowState = .authenticating
        errorMessage = nil
        
        do {
            let result = try await loginUseCase.execute(with: credential)
            flowState = .success(result)
            coordinator?.handleAuthenticationSuccess(result: result)
        } catch let error as AuthError {
            flowState = .error(error)
            errorMessage = error.localizedDescription
        } catch {
            let authError = AuthError.unknown(error)
            flowState = .error(authError)
            errorMessage = authError.localizedDescription
        }
        
        isLoading = false
    }
    
    private func requestOTP(for request: OTPRequest) async {
        isLoading = true
        flowState = .requestingOTP(request)
        errorMessage = nil
        
        do {
            let result = try await requestOTPUseCase.execute(with: request)
            let otpState = OTPViewState(
                verificationId: result.verificationId,
                request: request,
                expiresAt: result.expiresAt
            )
            flowState = .verifyingOTP(verificationId: result.verificationId, request: request)
            coordinator?.showOTPVerification(state: otpState)
        } catch let error as AuthError {
            flowState = .error(error)
            errorMessage = error.localizedDescription
        } catch {
            let authError = AuthError.unknown(error)
            flowState = .error(authError)
            errorMessage = authError.localizedDescription
        }
        
        isLoading = false
    }
}

