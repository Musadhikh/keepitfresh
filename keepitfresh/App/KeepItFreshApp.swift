//
//  KeepItFreshApp.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 31/8/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct KeepItFreshApp: App {
    @State private var appState = AppState()
    
    init() {
        FirebaseApp.configure()
        
        // Configure Firestore with offline persistence
        let db = Firestore.firestore()
        let settings = db.settings
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: FirebaseConstants.sizeBytes) // 200MB
        db.settings = settings
    }
    
    var body: some Scene {
        WindowGroup {
            switch appState.currentState {
            case .splash:
                SplashView {
                    appState.completeSplash()
                }
            case .main:
                Text("Main")
            }
        }
    }
}
