//
//  RealmModelConvertible.swift
//  RealmDatabaseModule
//
//  Created by Codex on 22/2/26.
//  Summary: Contract that maps non-Realm domain models to Realm objects and back.
//

import Foundation
import RealmSwift

public protocol RealmModelConvertible: Object {
    associatedtype DomainModel: Sendable

    static func makeRealmObject(from model: DomainModel) -> Self
    func makeDomainModel() throws -> DomainModel
}
