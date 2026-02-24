//
//
//  ProductDetail.swift
//  keepitfresh
//
//  Created by musadhikh on 24/2/26.
//  Summary: ProductDetail
//
    

import Foundation

enum ProductDetail: Codable, Equatable, Sendable {
    case food(FoodDetail?)
    case beverage(FoodDetail?)
    case household(HouseholdDetail?)
    case personalCare(PersonalCareDetail?)
//    case medicine
//    case electronics
//    case pet
    case other(UnknownDetails?)
}
