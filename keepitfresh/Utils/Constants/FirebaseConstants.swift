//
//  FirebaseConstants.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

struct FirebaseConstants {
    private init() {}
    
    // MARK: - Firestore Settings
    
    /// Cache size for offline persistence (200MB)
    static let cacheSize: NSNumber = NSNumber(integerLiteral: Int(200 * 1024 * 1024))
    
    // MARK: - Collection Names
    
    struct Collections {
        private init() {}
        
        /// Application metadata collection
        static let appMetadata = "AppMetadata"
        
        /// Users collection
        static let users = "Users"
        
        /// User profiles collection
        static let profiles = "Profiles"
        
        /// Houses/Households collection
        static let houses = "Houses"
        
        /// Items/Inventory collection
        static let items = "Items"
        
        /// Shopping lists collection
        static let shoppingLists = "ShoppingLists"
        
        /// Notifications collection
        static let notifications = "Notifications"
    }
    
    // MARK: - Document IDs
    
    struct Documents {
        private init() {}
    }
}
