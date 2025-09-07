//
//  AppState.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

@Observable
final class AppState {
    enum State {
        case splash
        case main
    }
    
    private(set) var currentState: State = .splash
    
    func completeSplash() {
        withAnimation(.easeInOut(duration: 0.5)) {
            currentState = .main
        }
    }
}

// MARK: - Preview Support
#if DEBUG
extension AppState {
    static var preview: AppState { AppState() }
}
#endif
