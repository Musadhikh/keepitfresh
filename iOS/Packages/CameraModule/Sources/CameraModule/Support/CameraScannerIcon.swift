//
//  CameraScannerIcon.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Centralizes SF Symbol identifiers used by camera scanner controls.
//

import Foundation

enum CameraScannerIcon: String {
    case photoLibrary = "photo.on.rectangle.angled"
    case flashOn = "bolt.fill"
    case flashOff = "bolt.slash.fill"
    case cancel = "xmark"
    case done = "checkmark"
    case delete = "xmark.circle.fill"
    case warning = "exclamationmark.triangle.fill"
    
    var systemName: String { rawValue }
}
