//
//  LoginView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/11/25.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Theme.Colors.accentSoft, Theme.Colors.background],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Header
                        LoginHeaderView()
                        Spacer()
                        // Login methods
                        VStack(spacing: 16) {
                            ForEach(viewModel.availableMethods, id: \.self) { method in
                                switch method {
                                case .apple:
                                    AppleSignInButton { result in
                                        switch result {
                                        case .success(let res):
                                            signIn(with: res)
                                        case .failure(let err):
                                            print("Error: \(err)")
                                            
                                        }
                                        
                                    }
                                    .frame(height: 40)
                                    
                                case .google:
                                    if let topViewController = UIViewController.topViewController() {
                                        GoogleSignInButton {
                                            signIn(with: .google(topViewController))
                                        }
                                        .frame(height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                case .anonymous:
                                    Button("Continue as Guest") {
                                        signIn(with: .anonymous)
                                    }
                                    .font(Theme.Fonts.body(16, weight: .semibold))
                                    .foregroundStyle(Theme.Colors.textPrimary)
                                    .padding(.top)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Error message
                        if let errorMessage = viewModel.errorMessage {
                            ErrorMessageView(message: errorMessage)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 40)
                }
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.inline)
        }
        .disabled(viewModel.isLoading)
    }
    
    private func signIn(with type: LoginType) {
        Task { await viewModel.singIn(with: type) }
    }
}

// MARK: - Login Header View

private struct LoginHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(icon: .loginBrand)
                .font(.system(size: 80))
                .foregroundStyle(Theme.Colors.accent.gradient)
            
            Text("KeepItFresh")
                .font(Theme.Fonts.titleLarge)
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Never waste food again")
                .font(Theme.Fonts.body(14, weight: .medium))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("KeepItFresh - Never waste food again")
    }
}


// MARK: - Error Message View

private struct ErrorMessageView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(icon: .warning)
                .foregroundStyle(Theme.Colors.danger)
            
            Text(message)
                .font(Theme.Fonts.caption)
                .foregroundStyle(Theme.Colors.danger)
            
            Spacer()
        }
        .padding()
        .background(Theme.Colors.danger.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.r12))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Error: \(message)")
    }
}

// MARK: - Preview

#if DEBUG
#Preview("Login View - All Methods") {
    LoginView(viewModel: LoginViewModel())
}

#Preview("Login View - Loading") {
    let viewModel = LoginViewModel()
    viewModel.isLoading = true
    return LoginView(viewModel: viewModel)
}

#Preview("Login View - Error") {
    let viewModel = LoginViewModel()
    viewModel.errorMessage = "Invalid credentials. Please try again."
    return LoginView(viewModel: viewModel)
}
#endif
