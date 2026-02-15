//
//  ProfileView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import SwiftUI
import Factory

struct ProfileView: View {
    
    @Environment(AppState.self) private var appState
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 40)
                } else if let profile = viewModel.profile {
                    profileContent(profile)
                } else {
                    emptyState
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Profile")
        .task {
            await viewModel.fetchProfile()
        }
        .refreshable {
            await viewModel.fetchProfile()
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
        .confirmationDialog(
            "Delete Account",
            isPresented: $viewModel.showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete Account", role: .destructive) {
                Task {
                    await viewModel.deleteAccount()
                    if viewModel.errorMessage == nil {
                        appState.requireAuthentication()
                    }
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone. All your data will be permanently deleted.")
        }
    }
    
    // MARK: - Profile Content
    
    @ViewBuilder
    private func profileContent(_ profile: Profile) -> some View {
        VStack(spacing: 24) {
            // Avatar Section
            avatarSection(profile)
            
            // User Info Section
            userInfoSection(profile)
            
            Divider()
                .padding(.vertical, 8)
            
            // Action Buttons
            actionButtons
        }
        .padding(.top, 24)
    }
    
    @ViewBuilder
    private func avatarSection(_ profile: Profile) -> some View {
        VStack(spacing: 12) {
            if let avatarURL = profile.avatarURL, let url = URL(string: avatarURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    avatarPlaceholder(name: profile.name)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            } else {
                avatarPlaceholder(name: profile.name)
            }
            
            Text(profile.name)
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            
            if let email = profile.email {
                Text(email)
                    .font(Theme.Fonts.body(14, weight: .medium))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
    }
    
    @ViewBuilder
    private func avatarPlaceholder(name: String) -> some View {
        Circle()
            .fill(Color.accentColor.gradient)
            .frame(width: 100, height: 100)
            .overlay {
                Text(name.prefix(1).uppercased())
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(.white)
            }
    }
    
    @ViewBuilder
    private func userInfoSection(_ profile: Profile) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            infoRow(label: "User ID", value: profile.userId)
            
            if !profile.householdIds.isEmpty {
                infoRow(label: "Households", value: "\(profile.householdIds.count)")
            }
            
            infoRow(
                label: "Account Status",
                value: profile.isActive ? "Active" : "Inactive"
            )
            
            if let createdAt = profile.createdAt {
                infoRow(
                    label: "Member Since",
                    value: createdAt.formatted(date: .abbreviated, time: .omitted)
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Theme.Colors.surface)
        .overlay {
            RoundedRectangle(cornerRadius: Theme.Radius.r12)
                .stroke(Theme.Colors.border, lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.r12))
    }
    
    @ViewBuilder
    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(Theme.Fonts.body(14, weight: .medium))
                .foregroundStyle(Theme.Colors.textSecondary)
            Spacer()
            Text(value)
                .font(Theme.Fonts.body(14, weight: .medium))
                .fontWeight(.medium)
                .foregroundStyle(Theme.Colors.textPrimary)
        }
    }
    
    @ViewBuilder
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                appState.navigate(to: .profileDetails)
            } label: {
                HStack {
                    Image(icon: .profileDetails)
                    Text("Account Details")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.Colors.surfaceAlt)
                .foregroundStyle(Theme.Colors.textPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.r12))
            }
            
            Button {
                appState.navigate(to: .householdSelection)
            } label: {
                HStack {
                    Image(icon: .householdSelection)
                    Text("Manage Households")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.Colors.surfaceAlt)
                .foregroundStyle(Theme.Colors.textPrimary)
                .clipShape(.rect(cornerRadius: Theme.Radius.r12))
            }
            
            // Logout Button
            Button {
                Task {
                    do {
                        try await viewModel.logout()
                        appState.requireAuthentication()
                    } catch {
                        viewModel.errorMessage = "Failed to logout: \(error.localizedDescription)"
                    }
                }
            } label: {
                HStack {
                    Image(icon: .logout)
                    Text("Logout")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.Colors.accent)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.r12))
            }
            
            // Delete Account Button
            Button {
                viewModel.showDeleteConfirmation = true
            } label: {
                HStack {
                    if viewModel.isDeleting {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Image(icon: .delete)
                        Text("Delete Account")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.Colors.danger)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.r12))
            }
            .disabled(viewModel.isDeleting)
        }
    }
    
    @ViewBuilder
    private var emptyState: some View {
        ContentUnavailableView {
            Label("No Profile", systemImage: Theme.Icon.profileUnavailable.systemName)
        } description: {
            Text("Unable to load your profile information")
        } actions: {
            Button("Retry") {
                Task {
                    await viewModel.fetchProfile()
                }
            }
        }
        .padding(.top, 40)
    }
}

#if DEBUG
#Preview {
    ProfileView()
        .environment(AppState())
}
#endif
