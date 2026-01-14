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
