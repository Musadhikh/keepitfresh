//
//  LoginView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/11/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea()
                
                GeometryReader { proxy in
                    ScrollView {
                        VStack(spacing: Theme.Spacing.s16) {
                            Spacer(minLength: 0)
                            
                            LoginHeaderView()
                            
                            LoginAuthCard(
                                availableMethods: viewModel.availableMethods,
                                onAppleSignIn: signIn(with:),
                                onGoogleSignIn: signInWithGoogle,
                                onEmailSignIn: signInWithEmail,
                                onGuestSignIn: { signIn(with: .anonymous) },
                                onError: { viewModel.errorMessage = $0 }
                            )
                            
                            if let errorMessage = viewModel.errorMessage {
                                ErrorMessageView(message: errorMessage)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .frame(minHeight: proxy.size.height - (Theme.Spacing.s32 * 2))
                        .padding(.horizontal, Theme.Spacing.s24)
                        .padding(.vertical, Theme.Spacing.s32)
                    }
                }
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
        .disabled(viewModel.isLoading)
        .onChange(of: viewModel.nextStep) { _, newStep in
            guard let newStep else { return }
            appState.applyLaunchDecision(newStep)
        }
    }
    
    private func signIn(with type: LoginType) {
        Task { await viewModel.singIn(with: type) }
    }
    
    @MainActor
    private func signInWithGoogle() {
        guard let topViewController = UIViewController.topViewController() else {
            viewModel.errorMessage = "Unable to start Google sign-in right now."
            return
        }
        signIn(with: .google(topViewController))
    }
    
    private func signInWithEmail() {
        viewModel.errorMessage = "Email sign-in is coming soon."
    }
}

private struct LoginHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
            Text("Welcome back")
                .font(Theme.Fonts.display(32, weight: .bold, relativeTo: .largeTitle))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Sign in to sync your homes, groceries, and expiry reminders.")
                .font(Theme.Fonts.body(15, weight: .medium, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textSecondary)
                .lineSpacing(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct LoginAuthCard: View {
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric(relativeTo: .headline) private var scaledButtonHeight: CGFloat = 50
    
    let availableMethods: [LoginMethod]
    let onAppleSignIn: (LoginType) -> Void
    let onGoogleSignIn: () -> Void
    let onEmailSignIn: () -> Void
    let onGuestSignIn: () -> Void
    let onError: (String) -> Void
    
    private var authButtonHeight: CGFloat {
        min(max(scaledButtonHeight, 50), 62)
    }
    
    var body: some View {
        VStack(spacing: Theme.Spacing.s12) {
            if availableMethods.contains(.apple) {
                AppleSignInButton { result in
                    switch result {
                    case .success(let loginType):
                        onAppleSignIn(loginType)
                    case .failure(let error):
                        onError("Apple sign-in failed: \(error.localizedDescription)")
                    }
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity)
                .frame(height: authButtonHeight)
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
            }
            
            if availableMethods.contains(.google) {
                Button(action: onGoogleSignIn) {
                    Text("Sign In with Google")
                        .frame(maxWidth: .infinity)
                        .frame(height: authButtonHeight)
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                        .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                }
                .buttonStyle(.plain)
                .background(colorScheme == .dark ? Color.white : Color.black)
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
            }
            
            Button("Continue with Email", action: onEmailSignIn)
                .primaryButtonStyle()
            
            if availableMethods.contains(.anonymous) {
                Button("Continue as Guest", action: onGuestSignIn)
                    .secondaryButtonStyle()
            }
        }
        .padding(Theme.Spacing.s16)
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.surface)
        .overlay {
            RoundedRectangle(cornerRadius: Theme.Radius.r24)
                .stroke(Theme.Colors.border, lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: Theme.Radius.r24))
    }
}

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
        .clipShape(.rect(cornerRadius: Theme.Radius.r12))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Error: \(message)")
    }
}

#if DEBUG
#Preview("Login View - All Methods") {
    LoginView(viewModel: LoginViewModel())
        .environment(AppState())
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
