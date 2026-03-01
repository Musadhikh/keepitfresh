//
//  RealmWritePolicy.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Write conflict policies used by repository upsert operations.
//

import Foundation

public enum RealmWritePolicy: Sendable, Hashable {
    case error
    case modified
    case all
}
