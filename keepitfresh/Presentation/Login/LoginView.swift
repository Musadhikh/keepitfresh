//
//  LoginView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/11/25.
//

import SwiftUI

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
                    colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
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
                                LoginMethodButton(
                                    method: method,
                                    isLoading: viewModel.isLoading
                                ) {
                                    handleMethodSelection(method)
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
        .onAppear {
            viewModel.loadAvailableMethods()
        }
    }
    
    // MARK: - Actions
    
    private func handleMethodSelection(_ method: LoginMethod) {
        Task {
            switch method {
            case .google:
                await viewModel.loginWithSocial(provider: .google)
            case .apple:
                await viewModel.loginWithSocial(provider: .apple)
            case .anonymous:
                await viewModel.continueAsGuest()
            default:
                viewModel.selectLoginMethod(method)
            }
        }
    }
}

// MARK: - Login Header View

private struct LoginHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green.gradient)
            
            Text("KeepItFresh")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Never waste food again")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("KeepItFresh - Never waste food again")
    }
}

// MARK: - Login Method Button

private struct LoginMethodButton: View {
    let method: LoginMethod
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                methodIcon
                    .font(.title3)
                    .frame(width: 24)
                
                Text(method.title)
                    .fontWeight(.medium)
                
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(buttonBackground)
            .foregroundStyle(buttonForeground)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .disabled(isLoading)
        .accessibilityLabel("Sign in with \(method.title)")
    }
    
    @ViewBuilder
    private var methodIcon: some View {
        switch method {
        case .emailPassword:
            Image(systemName: "envelope.fill")
        case .emailOTP:
            Image(systemName: "envelope.badge.shield.half.filled")
        case .mobileOTP:
            Image(systemName: "phone.fill")
        case .google:
            Image(systemName: "globe")
        case .apple:
            Image(systemName: "apple.logo")
        case .anonymous:
            Image(systemName: "person.fill.questionmark")
        }
    }
    
    private var buttonBackground: some View {
        Group {
            switch method {
            case .apple:
                Color.black
            case .google:
                Color.blue
            case .anonymous:
                Color.gray
            default:
                Color.accentColor
            }
        }
    }
    
    private var buttonForeground: Color {
        .white
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Error: \(message)")
    }
}

// MARK: - Preview

#if DEBUG
#Preview("Login View - All Methods") {
    LoginView(viewModel: PreviewDependencyContainer.shared.makeLoginViewModel())
}

#Preview("Login View - Loading") {
    let viewModel = PreviewDependencyContainer.shared.makeLoginViewModel()
    viewModel.isLoading = true
    return LoginView(viewModel: viewModel)
}

#Preview("Login View - Error") {
    let viewModel = PreviewDependencyContainer.shared.makeLoginViewModel()
    viewModel.errorMessage = "Invalid credentials. Please try again."
    return LoginView(viewModel: viewModel)
}
#endif
