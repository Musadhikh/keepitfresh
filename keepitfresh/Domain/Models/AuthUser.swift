//
//  AuthUser.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import Foundation

struct AuthUser:Sendable, Codable, Identifiable, Equatable {
    let id: String
    let email: String?
    let name: String?
    let photo: URL?
    
    init(id: String, email: String? = nil, name: String? = nil, photo: URL? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.photo = photo
    }
}
