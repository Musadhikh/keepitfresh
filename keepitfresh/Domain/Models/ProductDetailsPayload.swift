//
//  ProductDetailsPayload.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Discriminated union for category-specific detail payloads.
//

import Foundation

/// One-of payload for category-specific details.
enum ProductDetailsPayload: Equatable, Sendable {
    case food(FoodDetails)
    case household(HouseholdDetails)
    case personalCare(PersonalCareDetails)
    case unknown(UnknownDetails)
}

extension ProductDetailsPayload: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
        case data
    }

    private enum PayloadType: String, Codable {
        case food
        case household
        case personalCare = "personal_care"
        case unknown
    }

    init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
            self = .unknown(.empty)
            return
        }

        let type = (try? container.decode(PayloadType.self, forKey: .type)) ?? .unknown
        switch type {
        case .food:
            if let value = try? container.decode(FoodDetails.self, forKey: .data) {
                self = .food(value)
            } else {
                self = .unknown(.empty)
            }
        case .household:
            if let value = try? container.decode(HouseholdDetails.self, forKey: .data) {
                self = .household(value)
            } else {
                self = .unknown(.empty)
            }
        case .personalCare:
            if let value = try? container.decode(PersonalCareDetails.self, forKey: .data) {
                self = .personalCare(value)
            } else {
                self = .unknown(.empty)
            }
        case .unknown:
            let value = (try? container.decode(UnknownDetails.self, forKey: .data)) ?? .empty
            self = .unknown(value)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .food(let value):
            try container.encode(PayloadType.food, forKey: .type)
            try container.encode(value, forKey: .data)
        case .household(let value):
            try container.encode(PayloadType.household, forKey: .type)
            try container.encode(value, forKey: .data)
        case .personalCare(let value):
            try container.encode(PayloadType.personalCare, forKey: .type)
            try container.encode(value, forKey: .data)
        case .unknown(let value):
            try container.encode(PayloadType.unknown, forKey: .type)
            try container.encode(value, forKey: .data)
        }
    }
}
