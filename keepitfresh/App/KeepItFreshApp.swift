//
//  KeepItFreshApp.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 31/8/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

@main
struct KeepItFreshApp: App {
    @State private var appState = AppState()
    
    private let dependencies: any DependencyContainer
    private let splashViewModel: SplashViewModel
    
    init() {
        FirebaseApp.configure()
        
        // Configure Google Sign-In
        GoogleSignInConfig.configure()
        
        // Configure Firestore with offline persistence
        let db = Firestore.firestore()
        let settings = db.settings
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: FirebaseConstants.sizeBytes) // 200MB
        db.settings = settings
        
        let dependencies = PreviewDependencyContainer()
        self.dependencies = dependencies
        self.splashViewModel = SplashViewModel(useCase: dependencies.appLaunchUseCase())
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appState.currentState {
                case .splash:
                    SplashView(viewModel: splashViewModel)
                case .authentication:
                    Text("Login Screen")
                case .main:
                    Text("Main Screen")
                }
            }
            .environment(appState)
            .onOpenURL { url in
                GoogleSignInConfig.handleURL(url)
            }
        }
    }
}
