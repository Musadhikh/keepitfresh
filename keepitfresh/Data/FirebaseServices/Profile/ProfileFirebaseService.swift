//
//  ProfileFirebaseService.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import FirebaseFirestore

actor ProfileFirebaseService: ProfileProviding {
    
    private let db = Firestore.firestore()
    
    func getProfile(for userId: String) async throws -> Profile? {
        let doc = try await db
            .collection(FirebaseConstants.Collections.profiles)
            .document(userId)
            .getDocument()
        
        guard doc.data() != nil else {
            app.debug("profile is nil")
            return nil
        }
        let profile = try doc.data(as: Profile.self)
        return profile
    }

    func create(profile: Profile) async throws {
        let data = try profile.asDictionary
        try await db
            .collection(FirebaseConstants.Collections.profiles)
            .document(profile.userId)
            .setData(data)
        
        app.debug("created profile")
    }

    func update(profile: Profile) async throws {
        let data = try profile.asDictionary
        try await db
            .collection(FirebaseConstants.Collections.profiles)
            .document(profile.userId)
            .updateData(data)
    }

    func delete(userId: String) async throws {
        try await db
            .collection(FirebaseConstants.Collections.profiles)
            .document(userId)
            .delete()
    }
}
