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
                firebase.error("App metadata collection is empty")
                throw AppMetadataError.documentNotFound
            }
            
            guard document.exists else {
                firebase.error("App metadata document does not exist")
                throw AppMetadataError.documentNotFound
            }
            
            let data = document.data()
            
            // Decode Firestore data to AppMetadata
            let metadata = try decodeMetadata(from: data)
            
            firebase.debug("Successfully fetched app metadata (docId: \(document.documentID)): data=\(metadata)")
            
            return metadata
            
        } catch let error as AppMetadataError {
            throw error
        } catch {
            firebase.error("Failed to fetch app metadata", error: error)
            throw AppMetadataError.firestoreError(error)
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func decodeMetadata(from data: [String: Any]) throws -> AppMetadata {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            return try JSONDecoder().decode(AppMetadata.self, from: jsonData)
        } catch {
            firebase.error("Failed to decode app metadata", error: error)
            throw AppMetadataError.decodingFailed(error)
        }
    }
}
