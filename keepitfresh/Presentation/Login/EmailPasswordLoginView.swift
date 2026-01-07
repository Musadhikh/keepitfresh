//
//  EmailPasswordLoginView.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import SwiftUI

struct EmailPasswordLoginView: View {
    @State private var viewModel: LoginViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecurePassword: Bool = true
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case email
        case password
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "envelope.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue.gradient)
                    
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.top, 40)
                
                // Form
                VStack(spacing: 16) {
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        TextField("Enter your email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            if isSecurePassword {
                                SecureField("Enter your password", text: $password)
                                    .textContentType(.password)
                                    .focused($focusedField, equals: .password)
                            } else {
                                TextField("Enter your password", text: $password)
                                    .textContentType(.password)
                                    .focused($focusedField, equals: .password)
                            }
                            
                            Button(action: { isSecurePassword.toggle() }) {
                                Image(systemName: isSecurePassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundStyle(.secondary)
                            }
                            .accessibilityLabel(isSecurePassword ? "Show password" : "Hide password")
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(message: errorMessage)
                        .padding(.horizontal)
                }
                
                // Sign In Button
                Button(action: signIn) {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.accentColor : Color.gray)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(!isFormValid || viewModel.isLoading)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Forgot Password
                Button("Forgot Password?") {
                    // Handle forgot password
                }
                .font(.subheadline)
                .foregroundStyle(.blue)
                
                Spacer()
            }
        }
        .navigationTitle("Email Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .onSubmit(signIn)
    }
    
    // MARK: - Computed Properties
    
    private var isFormValid: Bool {
        !email.isEmpty && email.contains("@") && password.count >= 6
    }
    
    // MARK: - Actions
    
    private func signIn() {
        guard isFormValid else { return }
        focusedField = nil
        
        Task {
            await viewModel.loginWithEmailPassword(
                email: email,
                password: password
            )
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
#Preview("Email Password Login") {
    NavigationStack {
        EmailPasswordLoginView(
            viewModel: PreviewDependencyContainer.shared.makeLoginViewModel()
        )
    }
}

#Preview("Email Password Login - Error") {
    let viewModel = PreviewDependencyContainer.shared.makeLoginViewModel()
    viewModel.errorMessage = "Invalid email or password"
    return NavigationStack {
        EmailPasswordLoginView(viewModel: viewModel)
    }
}
#endif
