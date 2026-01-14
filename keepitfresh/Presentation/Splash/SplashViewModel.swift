//
//  SplashViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI
import Observation

@Observable
@MainActor
final class SplashViewModel {
    private(set) var isLoading = true
    private(set) var shouldNavigate = false
    private(set) var launchState: AppLaunchState?
    private(set) var launchError: Error?
    
    private let minimumSplashDuration: TimeInterval = 2.0
    @ObservationIgnored private var hasStarted = false
    
    private let launchUseCase: AppLaunchUseCase
    
    init() {
        self.launchUseCase = AppLaunchUseCase()
    }
    
    func start() async {
        guard !hasStarted else { return }
        hasStarted = true
        await startSplashSequence()
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
        
        isLoading = false
        shouldNavigate = true
    }
    
    private func performInitializationTasks() async {
        do {
            launchState = try await launchUseCase.execute()
        } catch {
            launchError = error
        }
    }
}

// MARK: - Preview Support
#if DEBUG
extension SplashViewModel {
    static var preview: SplashViewModel {
        SplashViewModel()
    }
}
#endif
