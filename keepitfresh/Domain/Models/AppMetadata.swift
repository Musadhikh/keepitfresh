//
//  AppMetadata.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct AppMetadata: Codable, Equatable, Sendable {
    let message: String
    let minimumVersion: String
    let appStoreUrl: String
}
