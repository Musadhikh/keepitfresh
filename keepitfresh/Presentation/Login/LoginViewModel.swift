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
    
    let useCase: LoginUseCase
    
    // MARK: - Initialization
    init() {
        self.useCase = LoginUseCase()
    }
    
    func singIn(with type: LoginType) async {
        do {
            let provider = type.provider()
            try await useCase.login(with: provider)
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

