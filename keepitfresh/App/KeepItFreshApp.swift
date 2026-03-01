//
//  KeepItFreshApp.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 31/8/25.
//  Summary: App entry point that configures Firebase services and global app state.
//

import SwiftUI
import Factory
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn
import ProductModule

@main
struct KeepItFreshApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var appState = AppState()
    private let connectivityProvider: AppConnectivityProvider = .shared
    private let productSyncTrigger = ProductPendingSyncTrigger(
        service: Container.shared.productModuleService()
    )
    
    
    init() {
        FirebaseApp.configure()
        
        // Configure Google Sign-In
        GoogleSignInConfig.configure()

        // Configure Firestore with offline persistence.
        let db = Firestore.firestore()
        let settings = db.settings
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: FirebaseConstants.cacheSize)
        db.settings = settings
    }
    
    var body: some Scene {
        WindowGroup {
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
                await triggerProductPendingSyncIfNeeded()
            }
            .onChange(of: scenePhase) { _, newValue in
                guard newValue == .active else { return }
                Task {
                    await triggerProductPendingSyncIfNeeded()
                }
            }
        }
    }

    private func triggerProductPendingSyncIfNeeded() async {
        await productSyncTrigger.triggerIfNeeded(
            appState: appState.currentState,
            isSceneActive: scenePhase == .active,
            limit: 100
        )
    }
}

private actor ProductPendingSyncTrigger {
    private let service: any ProductModuleServicing
    private var lastAttemptAt: Date?
    private var isSyncing = false
    private let minimumAttemptInterval: TimeInterval = 60

    init(service: any ProductModuleServicing) {
        self.service = service
    }

    func triggerIfNeeded(appState: AppState.State, isSceneActive: Bool, limit: Int?) async {
        guard appState == .main, isSceneActive else {
            return
        }
        guard isSyncing == false else {
            return
        }
        let now = Date()
        if let lastAttemptAt, now.timeIntervalSince(lastAttemptAt) < minimumAttemptInterval {
            return
        }

        isSyncing = true
        lastAttemptAt = now
        defer { isSyncing = false }

        do {
            _ = try await service.syncPending(limit: limit)
        } catch {
            // No-op: sync is best-effort and retried on future lifecycle triggers.
        }
    }
}
