//
//  User.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

// Domain/Model/User.swift

struct User: Codable, Equatable, Identifiable, Sendable {
    let id: String
    let name: String
    let email: String?
    let profileImageURL: String?
    let createdAt: Date?
    let updatedAt: Date?
}
