//
//  AppDependencyContainer.swift
//  keepitfresh
//
//  Created by Codex on 11/11/24.
//

import Foundation

protocol DependencyContainer {
    func appLaunchUseCase() -> AppLaunchUseCase
}

struct AppDependencyContainer {
}

