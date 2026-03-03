//
//
//  Coordinator.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: Coordinator
//
    

import SwiftUI

@MainActor
protocol Coordinator: AnyObject {
    associatedtype Route: Hashable
    
    var path: NavigationPath { get set }
    
    func navigate(to: Route)
    func navigateBack()
}

@MainActor
extension Coordinator {
    func navigate(to: Route) {
        path.append(to)
    }
    
    func navigateBack() {
        path.removeLast()
    }
}
