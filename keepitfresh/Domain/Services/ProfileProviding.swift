//
//  ProfileProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol UserProfileProviding: Sendable {
    func getUserProfile(for userId: String) async throws -> UserProfile
}
