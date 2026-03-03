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

        TabView(selection: $appState.selectedTab) {
            NavigationStack(path: $appState.homeNavigationPath) {
                HomeView()
                    .navigationDestination(for: AppRoute.self, destination: destination(for:))
            }
            .tabItem {
                Label("Home", systemImage: Theme.Icon.homeTab.systemName)
            }
            .badge(appState.homeExpiredBadgeCount > 0 ? Text("\(appState.homeExpiredBadgeCount)") : nil)
            .tag(AppTab.home)

            NavigationStack(path: $appState.inventoryNavigationPath) {
                InventoryView()
                    .navigationDestination(for: AppRoute.self, destination: destination(for:))
            }
            .tabItem {
                Label("Inventory", systemImage: Theme.Icon.stock.systemName)
            }
            .tag(AppTab.inventory)

            NavigationStack(path: $appState.profileNavigationPath) {
                ProfileView()
                    .navigationDestination(for: AppRoute.self, destination: destination(for:))
            }
            .tabItem {
                Label("Profile", systemImage: Theme.Icon.profileTab.systemName)
            }
            .tag(AppTab.profile)
        }
        .id(appState.houseSessionID)
        .fullScreenCover(isPresented: $appState.requiresHouseSelection) {
            NavigationStack {
                HouseSelectionView(mode: .required)
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
            HouseSelectionView(mode: .manage)
        case .addProduct(let type):
                addProductDestination(type: type)
        case .productsList:
            ProductsListView()
        case .inventoryItemDetail(let item):
            InventoryItemDetailView(item: item)
        }
    }

    private func addProductDestination(type: AddProductFlowType) -> some View {
       
        return AddProductModuleAssembler(
            defaultHouseholdId: appState.selectedHouse?.id ?? "default-household"
        )
        .makeRootView(type: type)
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
