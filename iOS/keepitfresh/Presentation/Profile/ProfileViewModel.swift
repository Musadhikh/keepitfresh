//
//  ProfileViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//  Summary: Loads profile offline-first and observes background sync updates in real time.
//

import Foundation
import Factory
import FirebaseAuth

@Observable
@MainActor
class ProfileViewModel {
    
    // MARK: - Dependencies
    
    @ObservationIgnored
    @Injected(\.userProvider) private var userProvider: UserProviding
    
    @ObservationIgnored
    @Injected(\.profileProvider) private var profileProvider: ProfileProviding

    @ObservationIgnored
    @Injected(\.profileSyncRepository) private var profileSyncRepository: ProfileSyncRepository
    
    // MARK: - State
    
    var profile: Profile?
    var isLoading = false
    var errorMessage: String?
    var showDeleteConfirmation = false
    var isDeleting = false
    var isUpdatingAppearance = false
    var selectedAppearancePreference: ProfileAppearancePreference = .system

    @ObservationIgnored
    private var profileObservationTask: Task<Void, Never>?
    
    // MARK: - Actions
    
    /// Fetches the current user's profile
    func fetchProfile() async {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            guard let user = try await userProvider.current() else {
                errorMessage = "No authenticated user found"
                return
            }
            
            profile = try await profileSyncRepository.currentProfile(for: user.id)
            selectedAppearancePreference = profile?.appearancePreference ?? .system
            startObservingProfileUpdates(for: user.id)
            await profileSyncRepository.synchronizeInBackground(for: user.id)
        } catch {
            errorMessage = "Failed to load profile: \(error.localizedDescription)"
        }
    }
    
    /// Signs out the current user
    func logout() async throws {
        try Auth.auth().signOut()
    }
    
    /// Deletes the current user's account and profile data
    func deleteAccount() async {
        isDeleting = true
        errorMessage = nil
        
        defer { 
            isDeleting = false
            showDeleteConfirmation = false
        }
        
        do {
            guard let user = try await userProvider.current() else {
                errorMessage = "No authenticated user found"
                return
            }
            
            // Delete profile data
            try await profileProvider.delete(userId: user.id)
            
            // Delete Firebase Auth account
            try await Auth.auth().currentUser?.delete()
        } catch {
            errorMessage = "Failed to delete account: \(error.localizedDescription)"
        }
    }

    func updateAppearancePreference(
        from previousPreference: ProfileAppearancePreference,
        to preference: ProfileAppearancePreference
    ) async {
        guard isUpdatingAppearance == false else { return }
        guard previousPreference != preference else { return }
        isUpdatingAppearance = true
        defer { isUpdatingAppearance = false }

        do {
            guard let user = try await userProvider.current() else {
                selectedAppearancePreference = previousPreference
                errorMessage = "No authenticated user found"
                return
            }

            if let updatedProfile = try await profileSyncRepository.setAppearancePreference(for: user.id, preference: preference) {
                profile = updatedProfile
            }
        } catch {
            selectedAppearancePreference = previousPreference
            errorMessage = "Failed to update app appearance: \(error.localizedDescription)"
        }
    }
}

private extension ProfileViewModel {
    func startObservingProfileUpdates(for userId: String) {
        profileObservationTask?.cancel()
        profileObservationTask = Task { [weak self] in
            guard let self else { return }
            let stream = await profileSyncRepository.observeRecord(for: userId)
            for await record in stream {
                guard !Task.isCancelled else { break }
                if let profile = record?.profile {
                    self.profile = profile
                    self.selectedAppearancePreference = profile.appearancePreference
                }
            }
        }
    }
}
