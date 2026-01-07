//
//  AuthError.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case networkError
    case invalidCredentials
    case accountDisabled
    case userCancel
    case unknownError(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network connection error. Please check your internet connection."
        case .invalidCredentials:
            return "Invalid email or password. Please try again."
        case .accountDisabled:
            return "Your account has been disabled. Please contact support."
        case .userCancel:
            return "Sign-in was cancelled."
        case .unknownError(let message):
            return "An unexpected error occurred: \(message)"
        case .unknown(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
