//
//  LoginViewModel.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/11/25.
//

import Foundation
import Observation

@MainActor
@Observable
class LoginViewModel {
    // MARK: - Properties
    
    let availableMethods: [LoginMethod] = [.apple, .google, .anonymous]
    var isLoading: Bool = false
    var errorMessage: String?
    var nextStep: AppLaunchState?
    
    let useCase: LoginUseCase
    
    // MARK: - Initialization
    init() {
        self.useCase = LoginUseCase()
    }
    
    func singIn(with type: LoginType) async {
        isLoading = true
        errorMessage = nil
        nextStep = nil
        defer { isLoading = false }
        
        do {
            let provider = type.provider()
            nextStep = try await useCase.login(with: provider)
        } catch GoogleAuthError.userCancelled {
            // Ignore user cancellation as it's not an error
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
