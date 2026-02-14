//
//  AppState.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

@MainActor
@Observable
final class AppState {
    enum State: Equatable {
        /// App is showing the splash/launch screen (cold start, warm start, or restoring from background)
        case splash
        /// App is temporarily blocked due to maintenance
        case maintenance
        /// App needs the user to authenticate (login/sign up, SSO, etc.)
        case authentication
        /// App is ready and showing the main content (post-auth)
        case main
    }
    
    private(set) var currentState: State = .splash
    var selectedTab: AppTab = .home
    var navigationPath = NavigationPath()
    
    /// Transition to maintenance screen
    func enterMaintenance() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .maintenance
            resetNavigation()
        }
    }
    
    /// Transition to authentication flow
    func requireAuthentication() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .authentication
            resetNavigation()
        }
    }

    /// Transition to main content after successful authentication or when user session is valid
    func enterMain() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .main
            resetNavigation()
        }
    }
    
    /// Apply launch/auth next-step routing in one place so splash and login share behavior.
    func applyLaunchState(_ launchState: AppLaunchState) {
        switch launchState {
        case .maintenance:
            enterMaintenance()
        case .loginRequired:
            requireAuthentication()
        case .updateRequired:
            enterMain()
        case .createHousehold, .selectHousehold:
            withAnimation(.easeInOut(duration: 0.3)) {
                currentState = .main
                setNavigation(tab: .home, routes: [.householdSelection])
            }
        case .mainContent:
            enterMain()
        }
    }
    
    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
    
    func setNavigation(tab: AppTab, routes: [AppRoute]) {
        selectedTab = tab
        navigationPath = NavigationPath()
        for route in routes {
            navigationPath.append(route)
        }
    }
    
    @discardableResult
    func handleDeepLink(_ url: URL) -> Bool {
        guard let destination = AppDeepLinkParser.parse(url) else { return false }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .main
            setNavigation(tab: destination.tab, routes: destination.routes)
        }
        return true
    }
    
    private func resetNavigation() {
        selectedTab = .home
        navigationPath = NavigationPath()
    }
}
