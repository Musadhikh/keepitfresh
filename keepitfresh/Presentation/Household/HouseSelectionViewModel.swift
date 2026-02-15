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
    @Injected(\.loadHouseholdsForCurrentUserUseCase)
    private var loadHouseholdsForCurrentUserUseCase: LoadHouseholdsForCurrentUserUseCase
    
    @ObservationIgnored
    @Injected(\.createHouseUseCase)
    private var createHouseUseCase: CreateHouseUseCase
    
    @ObservationIgnored
    @Injected(\.selectHouseUseCase)
    private var selectHouseUseCase: SelectHouseUseCase
    
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
            let output = try await loadHouseholdsForCurrentUserUseCase.execute()
            profile = output.profile
            selectedHouseID = output.profile.lastSelectedHouseholdId
            houses = output.houses.sorted {
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
        
        isCreatingHouse = true
        defer { isCreatingHouse = false }
        
        let output = try await createHouseUseCase.execute(
            input: .init(
                name: trimmedName,
                address: address,
                note: note
            )
        )
        profile = output.profile
        houses = (houses + [output.house]).sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }
        
        return output.house
    }
    
    /// Fetches latest house data and sets it as active in profile.
    func selectHouse(houseID: String) async throws -> House {
        let output = try await selectHouseUseCase.execute(houseID: houseID)
        profile = output.profile
        selectedHouseID = output.house.id
        
        houses.removeAll { $0.id == output.house.id }
        houses.append(output.house)
        houses.sort { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        
        return output.house
    }
}

private enum HouseSelectionError: LocalizedError {
    case emptyHouseName
    
    var errorDescription: String? {
        switch self {
        case .emptyHouseName:
            return "Please enter a house name."
        }
    }
}
