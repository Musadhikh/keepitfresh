//
//  AppState.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

@Observable
final class AppState {
    enum State: Equatable {
        /// App is showing the splash/launch screen (cold start, warm start, or restoring from background)
        case splash
        /// App needs the user to authenticate (login/sign up, SSO, etc.)
        case authentication
        /// App is ready and showing the main content (post-auth)
        case main
    }
    
    private(set) var currentState: State = .splash
    
    /// Transition to authentication flow
    func requireAuthentication() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .authentication
        }
    }

    /// Transition to main content after successful authentication or when user session is valid
    func enterMain() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .main
        }
    }
}
