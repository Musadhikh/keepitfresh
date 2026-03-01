//
//  KeepItFreshApp.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 31/8/25.
//  Summary: App entry point that configures Firebase services and launches RootView.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

@main
struct KeepItFreshApp: App {
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
            RootView()
        }
    }
}
