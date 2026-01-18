//
//  ProfileViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
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
    
    // MARK: - State
    
    var profile: Profile?
    var isLoading = false
    var errorMessage: String?
    var showDeleteConfirmation = false
    var isDeleting = false
    
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
            
            profile = try await profileProvider.getProfile(for: user.id)
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
}
