//
//  SignOutUseCase.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Use case for signing out user
protocol SignOutUseCaseProviding: Sendable {
    /// Sign out the current user
    /// - Throws: AuthError if sign out fails
    func execute() async throws
}

/// Implementation of sign out use case
struct SignOutUseCase: SignOutUseCaseProviding {
    private let authCoordinator: any AuthenticationCoordinatorProviding
    
    init(authCoordinator: any AuthenticationCoordinatorProviding) {
        self.authCoordinator = authCoordinator
    }
    
    func execute() async throws {
        // Add cleanup logic, clear cache, etc.
        try await authCoordinator.signOut()
    }
}
