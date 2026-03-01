//
//  FirebaseWritePolicy.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Global runtime switch for mocking Firebase writes while keeping reads live.
//

import Foundation

enum FirebaseWritePolicy {
    private static let storageKey = "keepitfresh.mock_firebase_writes_enabled"

    /// Global toggle:
    /// - true: Firestore writes are mocked/no-op
    /// - false: Firestore writes go to Firebase
    static var isMockWriteEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: storageKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: storageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: storageKey)
        }
    }
}
