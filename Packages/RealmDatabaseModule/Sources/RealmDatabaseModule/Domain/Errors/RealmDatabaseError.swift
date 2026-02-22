//
//  RealmDatabaseError.swift
//  RealmDatabaseModule
//
//  Created by Codex on 22/2/26.
//  Summary: Errors exposed by the Realm database module.
//

import Foundation

public enum RealmDatabaseError: Error, Sendable, Equatable {
    case primaryKeyNotDefined(typeName: String)
    case openRealmFailed(reason: String)
    case writeFailed(reason: String)
    case conversionFailed(typeName: String, reason: String)
}
