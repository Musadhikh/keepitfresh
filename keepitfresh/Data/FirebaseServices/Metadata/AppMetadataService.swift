//
//  AppMetadataService.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation
import FirebaseFirestore

/// Firebase Firestore implementation of `AppMetadataProviding`.
/// Fetches application metadata from the "AppMetadata" collection.
/// Expects exactly one document in the collection (with any document ID).
actor AppMetadataService: AppMetadataProviding {
    // MARK: - Error Types
    

    // MARK: - Private Properties

    private let db = Firestore.firestore()
    
    // MARK: - AppMetadataProviding Implementation
    
    func getAppMetadata() async throws -> AppMetadata {
        do {
            // Fetch all documents from the collection (should only be one)
            let querySnapshot = try await db
                .collection(FirebaseConstants.Collections.appMetadata)
                .limit(to: 1)
                .getDocuments()
            
            guard let document = querySnapshot.documents.first else {
                throw AppMetadataError.documentNotFound
            }
            
            guard document.exists else {
                throw AppMetadataError.documentNotFound
            }
            
            // Decode Firestore data to AppMetadata
            let metadata = try document.data(as: AppMetadata.self)
                        
            return metadata
            
        } catch let error as AppMetadataError {
            throw error
        } catch {
            throw AppMetadataError.firestoreError(error)
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func decodeMetadata(from data: [String: Any]) throws -> AppMetadata {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            return try JSONDecoder().decode(AppMetadata.self, from: jsonData)
        } catch {
            throw AppMetadataError.decodingFailed(error)
        }
    }
}
