//
//  AppRoute.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Declares typed app tabs/routes and parses deep links into navigation destinations.
//

import Foundation

enum AppTab: Hashable {
    case home
    case profile
}

enum AppRoute: Hashable {
    case appInfo
    case profileDetails
    case householdSelection
    case addProduct(barcodePayload: String?, symbology: String?)
    case productsList
}

enum AppDeepLinkParser {
    static func parse(_ url: URL) -> (tab: AppTab, routes: [AppRoute])? {
        guard url.scheme?.lowercased() == "keepitfresh",
              let host = url.host?.lowercased() else {
            return nil
        }
        
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        
        switch host {
        case "home":
            if pathComponents.first?.lowercased() == "add-product" {
                return (.home, [.addProduct(barcodePayload: nil, symbology: nil)])
            }
            if pathComponents.first?.lowercased() == "products" {
                return (.home, [.productsList])
            }
            return (.home, [])
        case "profile":
            if pathComponents.first?.lowercased() == "details" {
                return (.profile, [.profileDetails])
            }
            return (.profile, [])
        case "app-info":
            return (.home, [.appInfo])
        case "households":
            if pathComponents.first?.lowercased() == "select" {
                return (.home, [.householdSelection])
            }
            return nil
        default:
            return nil
        }
    }
}
