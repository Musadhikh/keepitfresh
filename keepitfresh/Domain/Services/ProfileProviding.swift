//
//  ProfileProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol UserProfileProviding {
    func getUserProfile(for userId: String) async throws -> UserProfile
}
