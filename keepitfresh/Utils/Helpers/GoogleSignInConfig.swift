//
//  GoogleSignInConfig.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import GoogleSignIn
import Firebase

enum GoogleSignInConfig {
    
    /// Configure Google Sign-In with the client ID from GoogleService-Info.plist
    static func configure() {
        if let clientId = clientId() {
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientId)
        } else {
#if DEBUG
            fatalError("GoogleService-Info.plist not found or CLIENT_ID missing")
#else
            app.critical("Warning: GoogleService-Info.plist not found or CLIENT_ID missing")
#endif
        }
        
        
    }
    
    /// Handle URL callback for Google Sign-In
    @discardableResult
    static func handleURL(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    static private func clientId() -> String? {
        if let clientId = FirebaseApp.app()?.options.clientID {
            return clientId
        }
        
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let clientId = plist["CLIENT_ID"] as? String else {
            return nil
        }
        
        return clientId
    }
}
