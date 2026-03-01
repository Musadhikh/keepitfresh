//
//  LoginViewState.swift
//  keepitfresh
//
//  Created by GitHub Copilot
//

import Foundation

/// Represents different login methods available
enum LoginMethod: Sendable, CaseIterable {
    case google
    case apple
    case anonymous
    
    var title: String {
        switch self {
        case .google: return "Google"
        case .apple: return "Apple"
        case .anonymous: return "Continue as Guest"
        }
    }
    
    var providerType: AuthProviderType {
        switch self {
        case .google: return .google
        case .apple: return .apple
        case .anonymous: return .anonymous
        }
    }
}
