//
//  OTPLoginView.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import SwiftUI

struct OTPLoginView: View {
    @State private var viewModel: LoginViewModel
    let method: LoginMethod
    
    @State private var emailOrPhone: String = ""
    @State private var countryCode: String = "+1"
    @FocusState private var isFocused: Bool
    
    init(viewModel: LoginViewModel, method: LoginMethod) {
        self.viewModel = viewModel
        self.method = method
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: headerIcon)
                        .font(.system(size: 60))
                        .foregroundStyle(.purple.gradient)
                    
                    Text(method == .emailOTP ? "Email Verification" : "Phone Verification")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("We'll send you a one-time password")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Input Form
                VStack(spacing: 16) {
                    if method == .mobileOTP {
                        // Country Code + Phone Number
                        HStack(spacing: 12) {
                            // Country Code Picker
                            Menu {
                                Button("+1 (US)") { countryCode = "+1" }
                                Button("+44 (UK)") { countryCode = "+44" }
                                Button("+91 (IN)") { countryCode = "+91" }
                            } label: {
                                HStack {
                                    Text(countryCode)
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            
                            // Phone Number Field
                            TextField("Phone number", text: $emailOrPhone)
                                .keyboardType(.phonePad)
                                .focused($isFocused)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    } else {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                            
                            TextField("Enter your email", text: $emailOrPhone)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                                .focused($isFocused)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(message: errorMessage)
                        .padding(.horizontal)
                }
                
                // Send OTP Button
                Button(action: sendOTP) {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Send Code")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isInputValid ? Color.accentColor : Color.gray)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(!isInputValid || viewModel.isLoading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
            }
        }
        .navigationTitle(method == .emailOTP ? "Email OTP" : "Phone OTP")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Computed Properties
    
    private var headerIcon: String {
        method == .emailOTP ? "envelope.badge.shield.half.filled" : "phone.badge.checkmark"
    }
    
    private var isInputValid: Bool {
        if method == .emailOTP {
            return !emailOrPhone.isEmpty && emailOrPhone.contains("@")
        } else {
            return !emailOrPhone.isEmpty && emailOrPhone.count >= 10
        }
    }
    
    // MARK: - Actions
    
    private func sendOTP() {
        guard isInputValid else { return }
        isFocused = false
        
        Task {
            if method == .emailOTP {
                await viewModel.requestEmailOTP(email: emailOrPhone)
            } else {
                await viewModel.requestMobileOTP(
                    phoneNumber: emailOrPhone,
                    countryCode: countryCode
                )
            }
        }
    }
}

// MARK: - OTP Verification View

struct OTPVerificationView: View {
    @State private var viewModel: LoginViewModel
    let otpState: OTPViewState
    
    @State private var otpCode: String = ""
    @FocusState private var isFocused: Bool
    
    init(viewModel: LoginViewModel, otpState: OTPViewState) {
        self.viewModel = viewModel
        self.otpState = otpState
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.green.gradient)
                    
                    Text("Enter Code")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(otpDestinationText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // OTP Input
                VStack(spacing: 16) {
                    TextField("6-digit code", text: $otpCode)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .focused($isFocused)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: otpCode) { _, newValue in
                            if newValue.count > 6 {
                                otpCode = String(newValue.prefix(6))
                            }
                        }
                }
                .padding(.horizontal)
                
                // Timer / Resend
                if otpState.canResend {
                    Button("Resend Code") {
                        resendOTP()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                } else {
                    Text("Resend in \(Int(otpState.remainingTime))s")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(message: errorMessage)
                        .padding(.horizontal)
                }
                
                // Verify Button
                Button(action: verifyOTP) {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Verify")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(otpCode.count == 6 ? Color.accentColor : Color.gray)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(otpCode.count != 6 || viewModel.isLoading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
            }
        }
        .navigationTitle("Verify Code")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isFocused = true
        }
    }
    
    // MARK: - Computed Properties
    
    private var otpDestinationText: String {
        switch otpState.request {
        case .email(let email):
            return "We sent a code to \(email)"
        case .mobile(let phone, let code):
            return "We sent a code to \(code) \(phone)"
        }
    }
    
    // MARK: - Actions
    
    private func verifyOTP() {
        guard otpCode.count == 6 else { return }
        isFocused = false
        
        Task {
            await viewModel.verifyOTP(
                verificationId: otpState.verificationId,
                otp: otpCode,
                request: otpState.request
            )
        }
    }
    
    private func resendOTP() {
        otpCode = ""
        Task {
            await viewModel.resendOTP(for: otpState.request)
        }
    }
}

// MARK: - Error Message View

private struct ErrorMessageView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
            
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
            
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - Preview

#if DEBUG
#Preview("Email OTP Login") {
    NavigationStack {
        OTPLoginView(
            viewModel: PreviewDependencyContainer.shared.makeLoginViewModel(),
            method: .emailOTP
        )
    }
}

#Preview("Mobile OTP Login") {
    NavigationStack {
        OTPLoginView(
            viewModel: PreviewDependencyContainer.shared.makeLoginViewModel(),
            method: .mobileOTP
        )
    }
}

#Preview("OTP Verification") {
    NavigationStack {
        OTPVerificationView(
            viewModel: PreviewDependencyContainer.shared.makeLoginViewModel(),
            otpState: OTPViewState(
                verificationId: "test-id",
                request: .email(email: "test@example.com"),
                expiresAt: Date().addingTimeInterval(300)
            )
        )
    }
}
#endif
