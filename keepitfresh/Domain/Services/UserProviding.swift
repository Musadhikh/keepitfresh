//
//  UserProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol UserProviding: Sendable {
    func current() async throws -> User?
    func validateSession() async throws
}
