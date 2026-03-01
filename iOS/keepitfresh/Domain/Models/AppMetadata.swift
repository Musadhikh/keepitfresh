//
//  AppMetadata.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct AppMetadata: Codable, Equatable, Sendable, CustomStringConvertible {
    let message: String
    let minimumVersion: String
    let appStoreUrl: String
    let isUnderMaintenance: Bool
    
    var description: String {
        "AppMetadata(message: \"\(message)\", minimumVersion: \(minimumVersion), appStoreUrl: \(appStoreUrl), isUnderMaintenance: \(isUnderMaintenance))"
    }
}
