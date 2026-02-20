//
//  ProductDetailsMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Maps category-specific extraction output into ProductDetails domain models.
//

import Foundation

struct ProductDetailsMapper {
    func makeDetails(
        productId: String,
        classification: ProductClassificationExtraction,
        common: ProductDetailsExtraction,
        food: FoodDetailsExtraction?,
        household: HouseholdDetailsExtraction?,
        personalCare: PersonalCareDetailsExtraction?
    ) -> ProductDetails? {
        guard let extractionCategory = classification.category else {
            return nil
        }

        let category = mappedMainCategory(extractionCategory)
        let now = Date()
        let payload = mappedPayload(
            category: category,
            common: common,
            food: food,
            household: household,
            personalCare: personalCare
        )

        return ProductDetails(
            productId: productId,
            category: category,
            schemaVersion: 1,
            packaging: mappedPackaging(from: common.packaging),
            dateInfo: mappedDateInfo(from: common.dateInfo),
            payload: payload,
            createdAt: now,
            updatedAt: now
        )
    }
}

private extension ProductDetailsMapper {
    func mappedMainCategory(_ category: MainCategoryExtraction) -> MainCategory {
        switch category {
        case .food:
            return .food
        case .beverage:
            return .beverage
        case .household:
            return .household
        case .personalCare:
            return .personalCare
        case .medicine:
            return .medicine
        case .electronics:
            return .electronics
        case .pet:
            return .pet
        case .other, .unknown:
            return .other
        }
    }

    func mappedPackaging(from extraction: ProductPackagingExtraction?) -> ProductPackaging? {
        guard let extraction else { return nil }
        return ProductPackaging(
            quantity: extraction.quantity,
            unit: mappedUnit(extraction.unit),
            count: extraction.count,
            displayText: normalized(extraction.displayText)
        )
    }

    func mappedUnit(_ unit: ProductPackagingUnitExtraction?) -> ProductPackaging.Unit {
        switch unit ?? .unknown {
        case .g:
            return .g
        case .kg:
            return .kg
        case .ml:
            return .ml
        case .l:
            return .l
        case .oz:
            return .oz
        case .lb:
            return .lb
        case .count:
            return .count
        case .unknown:
            return .unknown
        }
    }

    func mappedDateInfo(from extraction: [ProductDateInfoExtraction]?) -> [ProductDateInfo]? {
        guard let extraction else { return nil }
        let mapped = extraction.compactMap(mapDateInfo)
        return mapped.isEmpty ? nil : mapped
    }

    func mapDateInfo(_ extraction: ProductDateInfoExtraction) -> ProductDateInfo? {
        let confidence = normalizedConfidence(extraction.confidence)
        let isoDate: Date?
        if let confidence, confidence >= 0.8 {
            isoDate = parseISODate(extraction.isoDate)
        } else {
            isoDate = nil
        }

        return ProductDateInfo(
            kind: mappedDateKind(extraction.kind),
            rawText: normalized(extraction.rawText),
            isoDate: isoDate,
            confidence: confidence
        )
    }

    func mappedDateKind(_ kind: ProductDateKindExtraction?) -> ProductDateInfo.Kind {
        switch kind ?? .unknown {
        case .expiry:
            return .expiry
        case .bestBefore:
            return .bestBefore
        case .useBy:
            return .useBy
        case .manufactured:
            return .manufactured
        case .packedOn:
            return .packedOn
        case .unknown:
            return .unknown
        }
    }

    func mappedPayload(
        category: MainCategory,
        common: ProductDetailsExtraction,
        food: FoodDetailsExtraction?,
        household: HouseholdDetailsExtraction?,
        personalCare: PersonalCareDetailsExtraction?
    ) -> ProductDetailsPayload {
        switch category {
        case .food:
            guard let extraction = food ?? common.food else {
                return .unknown(unknownDetails(common: common))
            }
            return .food(
                FoodDetails(
                    ingredients: sanitized(extraction.ingredients),
                    allergens: sanitized(extraction.allergens),
                    nutritionPer100gOrMl: mappedNutrition(extraction.nutritionPer100gOrMl),
                    servingSize: normalized(extraction.servingSize),
                    countryOfOrigin: normalized(extraction.countryOfOrigin)
                )
            )
        case .household:
            guard let extraction = household ?? common.household else {
                return .unknown(unknownDetails(common: common))
            }
            return .household(
                HouseholdDetails(
                    usageInstructions: sanitized(extraction.usageInstructions),
                    safetyWarnings: sanitized(extraction.safetyWarnings),
                    materials: sanitized(extraction.materials)
                )
            )
        case .personalCare:
            guard let extraction = personalCare ?? common.personalCare else {
                return .unknown(unknownDetails(common: common))
            }
            return .personalCare(
                PersonalCareDetails(
                    usageDirections: sanitized(extraction.usageDirections),
                    ingredients: sanitized(extraction.ingredients),
                    warnings: sanitized(extraction.warnings),
                    skinType: sanitized(extraction.skinType)
                )
            )
        case .beverage, .medicine, .electronics, .pet, .other:
            return .unknown(unknownDetails(common: common))
        }
    }

    func mappedNutrition(_ extraction: NutritionFactsExtraction?) -> NutritionFacts? {
        guard let extraction else { return nil }
        return NutritionFacts(
            energyKcal: extraction.energyKcal,
            proteinG: extraction.proteinG,
            fatG: extraction.fatG,
            saturatedFatG: extraction.saturatedFatG,
            carbsG: extraction.carbsG,
            sugarsG: extraction.sugarsG,
            sodiumMg: extraction.sodiumMg
        )
    }

    func unknownDetails(common: ProductDetailsExtraction) -> UnknownDetails {
        var raw: [String: String] = [:]
        if let confidence = common.confidence {
            raw["confidence"] = String(confidence)
        }
        if let packagingText = common.packaging?.rawText, let packagingText = normalized(packagingText) {
            raw["packagingRawText"] = packagingText
        }
        if let firstDateText = common.dateInfo?.first?.rawText, let firstDateText = normalized(firstDateText) {
            raw["dateRawText"] = firstDateText
        }
        return UnknownDetails(raw: raw.isEmpty ? nil : raw)
    }

    func parseISODate(_ value: String?) -> Date? {
        guard let value = normalized(value) else { return nil }
        if let date = makeYYYYMMDDFormatter().date(from: value) {
            return date
        }
        if let date = makeISO8601FormatterWithFractionalSeconds().date(from: value) {
            return date
        }
        if let date = makeISO8601Formatter().date(from: value) {
            return date
        }
        return nil
    }

    func normalized(_ value: String?) -> String? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    func normalizedConfidence(_ value: Double?) -> Double? {
        guard let value else { return nil }
        return min(max(value, 0.0), 1.0)
    }

    func sanitized(_ values: [String]?) -> [String]? {
        guard let values else { return nil }
        var seen: Set<String> = []
        let result = values.compactMap { value -> String? in
            guard let normalized = normalized(value), seen.contains(normalized) == false else {
                return nil
            }
            seen.insert(normalized)
            return normalized
        }
        return result.isEmpty ? nil : result
    }

    func makeYYYYMMDDFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    func makeISO8601FormatterWithFractionalSeconds() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }

    func makeISO8601Formatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }
}
