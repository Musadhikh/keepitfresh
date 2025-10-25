//
//  HouseProviding.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

protocol HouseProviding {
    func getHouse(for houseId: String) async throws -> House
    func getHouses(for houseIds: [String]) async throws -> House
}
