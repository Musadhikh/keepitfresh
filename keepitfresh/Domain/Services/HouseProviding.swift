//
//  HouseProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//  Summary: Defines household data operations used by launch, login, and house selection flows.
//

import Foundation

protocol HouseProviding: Sendable {
    func getHouse(for houseId: String) async throws -> House
    func getHouses(for houseIds: [String]) async throws -> [House]
    func createHouse(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) async throws -> House
}
