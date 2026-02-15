//
//  HouseLoadPolicy.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines loading policies that control how local storage and network are consulted.
//

import Foundation

public enum HouseLoadPolicy: Sendable {
    case localOnly
    case remoteOnly
    case localFirst
    case remoteFirst
}

