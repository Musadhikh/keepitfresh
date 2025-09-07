//
//  SplashViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

@Observable
@MainActor
final class SplashViewModel {
    private(set) var isLoading = true
    private(set) var shouldNavigate = false
    
    private let minimumSplashDuration: TimeInterval = 2.0
    
    init() {
        Task {
            await startSplashSequence()
        }
    }
    
    
    private func startSplashSequence() async {
        let startTime = Date()
        
        // Perform any initialization tasks here
        await performInitializationTasks()
        
        // Ensure minimum splash duration
        let elapsed = Date().timeIntervalSince(startTime)
        if elapsed < minimumSplashDuration {
            let remainingTime = minimumSplashDuration - elapsed
            try? await Task.sleep(for: .seconds(remainingTime))
        }
        
        await MainActor.run {
            isLoading = false
            shouldNavigate = true
        }
    }
    
    private func performInitializationTasks() async {
        // Add any initialization logic here:
        // - Check authentication status
        // - Load user preferences
        // - Initialize Firebase
        // - Preload critical data
        
        // Simulate initialization work
        try? await Task.sleep(for: .seconds(0.5))
    }
}

// MARK: - Preview Support
#if DEBUG
extension SplashViewModel {
    static var preview: SplashViewModel { SplashViewModel() }
}
#endif
