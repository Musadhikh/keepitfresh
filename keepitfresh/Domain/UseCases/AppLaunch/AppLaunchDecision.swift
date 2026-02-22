//
//  AppLaunchDecision.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Bundles launch routing state with resolved profile and optional preselected house context.
//

import Foundation

struct AppLaunchDecision: Sendable, Equatable {
    let state: AppLaunchState
    let profile: Profile?
    let selectedHouse: House?
}

