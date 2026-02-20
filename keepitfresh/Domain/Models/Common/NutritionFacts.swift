//
//  NutritionFacts.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Stable normalized nutrition values per 100g/100ml.
//

import Foundation

struct NutritionFacts: Codable, Equatable, Sendable {
    var energyKcal: Double?
    var proteinG: Double?
    var fatG: Double?
    var saturatedFatG: Double?
    var carbsG: Double?
    var sugarsG: Double?
    var sodiumMg: Double?
}
