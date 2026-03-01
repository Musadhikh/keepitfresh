//
//  RootView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: App root container that owns app-state routing, environment wiring, and lifecycle sync triggers.
//

import SwiftUI
import Factory
import InventoryModule
import ProductModule

struct RootView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var appState = AppState()

    private let connectivityProvider: AppConnectivityProvider = .shared
    private let productSyncTrigger = ProductPendingSyncTrigger(
        service: Container.shared.productModuleService()
    )
    private let inventorySyncTrigger = InventoryPendingSyncTrigger(
        service: Container.shared.inventoryModuleService()
    )

    var body: some View {
        Group {
            switch appState.currentState {
            case .splash:
                SplashView(viewModel: SplashViewModel())
            case .maintenance:
                MaintenanceView()
            case .authentication:
                LoginView(viewModel: LoginViewModel())
            case .main:
                RootTabView()
            }
        }
        .environment(appState)
        .networkConnectivityProvider(connectivityProvider)
        .preferredColorScheme(appState.preferredColorScheme)
        .tint(Theme.Colors.accent)
        .onOpenURL { url in
            if GoogleSignInConfig.handleURL(url) {
                return
            }
            appState.handleDeepLink(url)
        }
        .task(id: appState.currentState) {
            await triggerPendingSyncIfNeeded()
        }
        .onChange(of: scenePhase) { _, newValue in
            guard newValue == .active else { return }
            Task {
                await triggerPendingSyncIfNeeded()
            }
        }
    }

    private func triggerPendingSyncIfNeeded() async {
        await productSyncTrigger.triggerIfNeeded(
            appState: appState.currentState,
            isSceneActive: scenePhase == .active,
            limit: 100
        )

        await inventorySyncTrigger.triggerIfNeeded(
            appState: appState.currentState,
            isSceneActive: scenePhase == .active,
            householdId: appState.selectedHouse?.id,
            limit: 100
        )
    }
}

#if DEBUG
#Preview {
    RootView()
}
#endif
