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
    @State private var loginViewModel: LoginViewModel?
    
    init() {
        FirebaseApp.configure()
        
        // Configure Google Sign-In
        GoogleSignInConfig.configure()
        
        // Configure Firestore with offline persistence
        let db = Firestore.firestore()
        let settings = db.settings
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: FirebaseConstants.cacheSize)
        db.settings = settings
        
        self.dependencies = ProcessInfo.isRunningForPreviews ? PreviewDependencyContainer() : AppDependencyContainer()
        self.splashViewModel = SplashViewModel(useCase: dependencies.appLaunchUseCase())
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appState.currentState {
                case .splash:
                    SplashView(viewModel: splashViewModel)
                case .maintenance:
                    MaintenanceView()
                case .authentication:
                    if let loginViewModel {
                        LoginView(viewModel: loginViewModel)
                    } else {
                        Color.clear
                            .onAppear {
                                loginViewModel = dependencies.makeLoginViewModel()
                            }
                    }
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

