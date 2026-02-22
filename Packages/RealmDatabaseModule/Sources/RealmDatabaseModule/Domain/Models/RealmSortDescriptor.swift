//
//  RealmSortDescriptor.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Domain-level sort descriptor to avoid exposing Realm types to callers.
//

import Foundation

public struct RealmSortDescriptor: Sendable, Hashable {
    public let keyPath: String
    public let ascending: Bool

    public init(keyPath: String, ascending: Bool = true) {
        self.keyPath = keyPath
        self.ascending = ascending
    }
}
