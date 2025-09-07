//
//  GoogleAuthProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

protocol GoogleAuthProviding: AuthProviding {
    /// Configure Google Sign-In with client ID
    func configure(clientId: String)
}
