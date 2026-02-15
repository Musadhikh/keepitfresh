//
//  HouseSelectionViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Manages household loading, creation, and switching using profile-scoped house IDs.
//

import Foundation
import Factory
import Observation

@MainActor
@Observable
final class HouseSelectionViewModel {
    @ObservationIgnored
    @Injected(\.userProvider) private var userProvider: UserProviding
    
    @ObservationIgnored
    @Injected(\.profileProvider) private var profileProvider: ProfileProviding
    
    @ObservationIgnored
    @Injected(\.houseProvider) private var houseProvider: HouseProviding
    
    private(set) var profile: Profile?
    private(set) var houses: [House] = []
    private(set) var isLoading = false
    private(set) var isCreatingHouse = false
    var selectedHouseID: String?
    var errorMessage: String?
    
    func loadHouseholds() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            guard let user = try await userProvider.current() else {
                throw HouseSelectionError.missingAuthenticatedUser
            }
            guard let profile = try await profileProvider.getProfile(for: user.id) else {
                throw HouseSelectionError.missingProfile
            }
            
            self.profile = profile
            selectedHouseID = profile.lastSelectedHouseholdId
            houses = try await houseProvider.getHouses(for: profile.householdIds).sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func createHouse(
        name: String,
        address: String,
        note: String
    ) async throws -> House {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            throw HouseSelectionError.emptyHouseName
        }
        
        guard let profile else {
            throw HouseSelectionError.missingProfile
        }
        guard let user = try await userProvider.current() else {
            throw HouseSelectionError.missingAuthenticatedUser
        }
        
        isCreatingHouse = true
        defer { isCreatingHouse = false }
        
        let description = mergeDescription(address: address, note: note)
        let createdHouse = try await houseProvider.createHouse(
            name: trimmedName,
            description: description,
            ownerId: user.id,
            memberIds: [user.id]
        )
        
        var updatedHouseholdIDs = profile.householdIds
        if !updatedHouseholdIDs.contains(createdHouse.id) {
            updatedHouseholdIDs.append(createdHouse.id)
        }
        
        let updatedProfile = Profile(
            id: profile.id,
            userId: profile.userId,
            name: profile.name,
            email: profile.email,
            avatarURL: profile.avatarURL,
            householdIds: updatedHouseholdIDs,
            lastSelectedHouseholdId: profile.lastSelectedHouseholdId,
            isActive: profile.isActive,
            createdAt: profile.createdAt,
            updatedAt: Date()
        )
        
        try await profileProvider.update(profile: updatedProfile)
        self.profile = updatedProfile
        houses = (houses + [createdHouse]).sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }
        
        return createdHouse
    }
    
    /// Fetches latest house data and sets it as active in profile.
    func selectHouse(houseID: String) async throws -> House {
        guard let profile else {
            throw HouseSelectionError.missingProfile
        }
        
        let latestHouse = try await houseProvider.getHouse(for: houseID)
        
        let updatedProfile = Profile(
            id: profile.id,
            userId: profile.userId,
            name: profile.name,
            email: profile.email,
            avatarURL: profile.avatarURL,
            householdIds: profile.householdIds,
            lastSelectedHouseholdId: latestHouse.id,
            isActive: profile.isActive,
            createdAt: profile.createdAt,
            updatedAt: Date()
        )
        
        try await profileProvider.update(profile: updatedProfile)
        self.profile = updatedProfile
        selectedHouseID = latestHouse.id
        
        houses.removeAll { $0.id == latestHouse.id }
        houses.append(latestHouse)
        houses.sort { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        
        return latestHouse
    }
    
    private func mergeDescription(address: String, note: String) -> String? {
        let normalizedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = [normalizedAddress, normalizedNote].filter { !$0.isEmpty }
        if parts.isEmpty {
            return nil
        }
        return parts.joined(separator: "\n")
    }
}

private enum HouseSelectionError: LocalizedError {
    case missingAuthenticatedUser
    case missingProfile
    case emptyHouseName
    
    var errorDescription: String? {
        switch self {
        case .missingAuthenticatedUser:
            return "No authenticated user found."
        case .missingProfile:
            return "Unable to load your profile."
        case .emptyHouseName:
            return "Please enter a house name."
        }
    }
}

