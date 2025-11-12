//
//  VersionCheckProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 12/11/25.
//

import Foundation

protocol VersionCheckProviding {
    func requiresVersionUpdate(metadata: AppMetadata) -> Bool
}
