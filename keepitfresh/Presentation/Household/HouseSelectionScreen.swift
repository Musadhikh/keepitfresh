//
//  HouseSelectionScreen.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Renders the household selection and creation experience for required and profile-manage flows.
//

import SwiftUI

enum HouseSelectionScreenMode: Sendable {
    case required
    case manage
}

struct HouseSelectionScreen: View {
    @Environment(AppState.self) private var appState
    let mode: HouseSelectionScreenMode
    
    @State private var viewModel = HouseSelectionViewModel()
    @State private var showCreateHouseSheet = false
    @State private var pendingCreatedHouse: House?
    @State private var showSwitchPrompt = false
    
    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.houses.isEmpty {
                    EmptyHouseState(action: { showCreateHouseSheet = true })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    HouseSelectionHeader(mode: mode)
                    
                    HouseListSection(
                        houses: viewModel.houses,
                        selectedHouseID: viewModel.selectedHouseID,
                        onSelect: handleHouseSelected
                    )
                }
                
                Button("Create House", icon: .houseCreate) {
                    showCreateHouseSheet = true
                }
                .primaryButtonStyle()
            }
            .padding(.horizontal, Theme.Spacing.s24)
            .padding(.vertical, Theme.Spacing.s24)
        }
        .navigationTitle("Houses")
        .navigationBarBackButtonHidden(mode == .required)
        .interactiveDismissDisabled(mode == .required)
        .task { await viewModel.loadHouseholds() }
        .refreshable { await viewModel.loadHouseholds() }
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.errorMessage = nil
                }
            })
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Something went wrong.")
        }
        .alert("Switch House?", isPresented: $showSwitchPrompt, presenting: pendingCreatedHouse) { createdHouse in
            Button("Keep Current", role: .cancel) {
                pendingCreatedHouse = nil
            }
            Button("Switch") {
                handleHouseSelected(createdHouse)
                pendingCreatedHouse = nil
            }
        } message: { createdHouse in
            Text("Switch to \(createdHouse.name) now?")
        }
        .sheet(isPresented: $showCreateHouseSheet) {
            CreateHouseSheet(
                isSubmitting: viewModel.isCreatingHouse,
                onCancel: { showCreateHouseSheet = false },
                onSubmit: handleCreateHouse
            )
            .presentationDetents([.height(600), .large])
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(mode == .required && viewModel.houses.isEmpty)
        }
    }
    
    private func handleCreateHouse(name: String, address: String, note: String) {
        Task {
            do {
                let createdHouse = try await viewModel.createHouse(
                    name: name,
                    address: address,
                    note: note
                )
                showCreateHouseSheet = false
                
                switch mode {
                case .required:
                    handleHouseSelected(createdHouse)
                case .manage:
                    pendingCreatedHouse = createdHouse
                    showSwitchPrompt = true
                }
            } catch {
                viewModel.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func handleHouseSelected(_ house: House) {
        Task {
            do {
                let selectedHouse = try await viewModel.selectHouse(houseID: house.id)
                appState.switchHouse(to: selectedHouse)
            } catch {
                viewModel.errorMessage = error.localizedDescription
            }
        }
    }
}

private struct HouseSelectionHeader: View {
    let mode: HouseSelectionScreenMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            Text(mode == .required ? "Select a house" : "Households")
                .font(Theme.Fonts.display(30, weight: .bold, relativeTo: .largeTitle))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Your households")
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct HouseListSection: View {
    let houses: [House]
    let selectedHouseID: String?
    let onSelect: (House) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.s12) {
                ForEach(houses) { house in
                    HouseRow(
                        house: house,
                        isSelected: selectedHouseID == house.id,
                        onSelect: { onSelect(house) }
                    )
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

private struct HouseRow: View {
    let house: House
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: Theme.Spacing.s12) {
                VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                    Text(house.name)
                        .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .body))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    if let description = house.description, !description.isEmpty {
                        Text(description)
                            .font(Theme.Fonts.caption)
                            .foregroundStyle(Theme.Colors.textSecondary)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                Image(icon: isSelected ? .houseSelected : .houseUnselected)
                    .font(Theme.Fonts.body(22, weight: .regular, relativeTo: .title3))
                    .foregroundStyle(isSelected ? Theme.Colors.accent : Theme.Colors.border)
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .frame(height: 64)
            .background(Theme.Colors.surface)
            .overlay {
                RoundedRectangle(cornerRadius: Theme.Radius.r16)
                    .stroke(Theme.Colors.border, lineWidth: 1)
            }
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
        }
        .buttonStyle(.plain)
    }
}

private struct EmptyHouseState: View {
    let action: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("No houses yet", systemImage: Theme.Icon.householdSelection.systemName)
        } description: {
            Text("Create your first house to continue.")
        }
    }
}


#if DEBUG
#Preview("House Selection - Required") {
    NavigationStack {
        HouseSelectionScreen(mode: .required)
            .environment(AppState())
    }
}

#Preview("House Selection - Manage") {
    NavigationStack {
        HouseSelectionScreen(mode: .manage)
            .environment(AppState())
    }
}
#endif

