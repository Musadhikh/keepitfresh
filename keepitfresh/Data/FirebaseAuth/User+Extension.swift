//
//  User+Extension.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation
import FirebaseAuth

extension User {
    var authUser: AuthUser {
        return AuthUser(
            id: uid,
            email: email,
            name: displayName,
            photo: photoURL
        )
    }
}
