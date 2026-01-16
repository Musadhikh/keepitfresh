//
//  AppLaunchState.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

enum AppLaunchState:String, Equatable, Sendable {
    case maintenance
    case updateRequired
    case loginRequired
    case createHousehold
    case selectHousehold
    case mainContent
}

