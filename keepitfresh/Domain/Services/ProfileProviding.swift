//
//  ProfileProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol ProfileProviding: Sendable {
    func getProfile(for userId: String) async throws -> Profile?
    func create(profile: Profile) async throws
    func update(profile: Profile) async throws
    func delete(userId: String) async throws
}
