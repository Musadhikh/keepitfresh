//
//  HouseSyncState.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Represents local synchronization status for household records.
//

import Foundation

public enum HouseSyncState: String, Sendable, Codable, Equatable {
    case pending
    case synced
    case failed
}
