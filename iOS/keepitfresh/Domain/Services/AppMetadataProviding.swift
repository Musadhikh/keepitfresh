//
//  AppMetadataProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol AppMetadataProviding: Sendable {
    func getAppMetadata() async throws -> AppMetadata
}
