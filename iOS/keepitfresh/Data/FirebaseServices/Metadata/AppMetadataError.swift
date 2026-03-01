//
//  AppMetadataError.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//


import Foundation

enum AppMetadataError: Error, LocalizedError {
    case documentNotFound
    case decodingFailed(Error)
    case firestoreError(Error)
    
    var errorDescription: String? {
        switch self {
        case .documentNotFound:
            return "App metadata document not found in Firestore."
        case .decodingFailed(let error):
            return "Failed to decode app metadata: \(error.localizedDescription)"
        case .firestoreError(let error):
            return "Firestore error: \(error.localizedDescription)"
        }
    }
}
