//
//  KeepItFreshApp.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 31/8/25.
//  Summary: App entry point that configures Firebase services and global app state.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

@main
struct KeepItFreshApp: App {
    @State private var appState = AppState()
    
    
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
            .tint(Theme.Colors.accent)
            
            .onOpenURL { url in
                if GoogleSignInConfig.handleURL(url) {
                    return
                }
                appState.handleDeepLink(url)
            }
        }
    }
}
