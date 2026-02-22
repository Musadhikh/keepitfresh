//
//  RootTabView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import SwiftUI

struct RootTabView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var appState = appState
        
        NavigationStack(path: $appState.navigationPath) {
            TabView(selection: $appState.selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: Theme.Icon.homeTab.systemName)
                    }
                    .tag(AppTab.home)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: Theme.Icon.profileTab.systemName)
                    }
                    .tag(AppTab.profile)
            }
            .navigationDestination(for: AppRoute.self, destination: destination(for:))
        }
        .id(appState.houseSessionID)
        .fullScreenCover(isPresented: $appState.requiresHouseSelection) {
            NavigationStack {
                HouseSelectionScreen(mode: .required)
            }
            .interactiveDismissDisabled()
        }
        .alert("Profile Updated", isPresented: Binding(
            get: { appState.globalProfileErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    appState.globalProfileErrorMessage = nil
                }
            }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(appState.globalProfileErrorMessage ?? "Your profile changed.")
        }
    }
    
    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .appInfo:
            AppInfoView()
        case .profileDetails:
            ProfileDetailsView()
        case .householdSelection:
            HouseSelectionScreen(mode: .manage)
        case .addProduct(let barcodePayload, let symbology):
            addProductDestination(barcodePayload: barcodePayload, symbology: symbology)
        }
    }

    private func addProductDestination(barcodePayload: String?, symbology: String?) -> some View {
        let initialBarcode = barcodePayload.flatMap { payload in
            payload.isEmpty ? nil : Barcode(value: payload, symbologyLabel: symbology)
        }

        return AddProductModuleAssembler(
            defaultHouseholdId: appState.selectedHouse?.id ?? "default-household"
        )
        .makeRootView(initialBarcode: initialBarcode)
    }
}

private struct AppInfoView: View {
    var body: some View {
        List {
            LabeledContent("App Name", value: "Keep It Fresh")
            LabeledContent("Build", value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")
            LabeledContent("Bundle ID", value: Bundle.main.bundleIdentifier ?? "Unknown")
        }
        .navigationTitle("App Info")
    }
}

private struct ProfileDetailsView: View {
    var body: some View {
        ContentUnavailableView(
            "Profile Details",
            systemImage: Theme.Icon.profileDetails.systemName,
            description: Text("Detailed account management screen can be plugged in here.")
        )
        .navigationTitle("Account")
    }
}

#if DEBUG
#Preview {
    RootTabView()
        .environment(AppState())
}
#endif
