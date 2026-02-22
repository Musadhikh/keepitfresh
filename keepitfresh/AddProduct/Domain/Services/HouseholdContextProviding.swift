//
//  HouseholdContextProviding.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Resolves active household context for inventory operations.
//

import Foundation

protocol HouseholdContextProviding: Sendable {
    func currentHouseholdId() async throws -> String
}
