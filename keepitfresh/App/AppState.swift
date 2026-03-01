//
//  AppState.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//  Summary: Global app navigation/session state with live profile-sync observation and house-context enforcement.
//

import SwiftUI
import Factory
import HouseModule

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
    var homeExpiredBadgeCount = 0
    private(set) var appearancePreference: ProfileAppearancePreference = .system
    var homeNavigationPath = NavigationPath()
    var profileNavigationPath = NavigationPath()
    private(set) var selectedHouse: House?
    private(set) var houseSessionID = UUID()
    var requiresHouseSelection = false
    var globalProfileErrorMessage: String?

    @ObservationIgnored
    private var userProvider: UserProviding {
        Container.shared.userProvider()
    }

    @ObservationIgnored
    private var profileSyncRepository: ProfileSyncRepository {
        Container.shared.profileSyncRepository()
    }

    @ObservationIgnored
    private var houseDomainModule: HouseModule {
        Container.shared.houseDomainModule()
    }

    @ObservationIgnored
    private var observedProfileUserID: String?

    @ObservationIgnored
    private var profileObservationTask: Task<Void, Never>?

    @ObservationIgnored
    private let appearancePreferenceDefaultsKey = "app.appearancePreference"

    init() {
        if let rawValue = UserDefaults.standard.string(forKey: appearancePreferenceDefaultsKey),
           let storedPreference = ProfileAppearancePreference(rawValue: rawValue) {
            appearancePreference = storedPreference
        }
    }

    var preferredColorScheme: ColorScheme? {
        switch appearancePreference {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
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
            requiresHouseSelection = false
            resetNavigation()
        }
    }

    /// Transition to main content after successful authentication or when user session is valid
    func enterMain() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .main
            requiresHouseSelection = false
            resetNavigation()
        }
    }
    
    /// Apply launch/auth next-step routing in one place so splash and login share behavior.
    func applyLaunchDecision(_ decision: AppLaunchDecision) {
        globalProfileErrorMessage = nil

        if let profile = decision.profile {
            applyAppearancePreference(profile.appearancePreference)
        }

        switch decision.state {
        case .maintenance:
            enterMaintenance()
        case .loginRequired:
            requireAuthentication()
        case .updateRequired:
            enterMain()
        case .createHousehold, .selectHousehold:
            requireHouseSelection()
        case .mainContent:
            enterMain()
            if let selectedHouse = decision.selectedHouse {
                applyResolvedHouseContext(selectedHouse)
            }
        }
        startProfileObservationIfNeeded()
    }

    func applyLaunchState(_ launchState: AppLaunchState) {
        applyLaunchDecision(
            AppLaunchDecision(
                state: launchState,
                profile: nil,
                selectedHouse: nil
            )
        )
    }
    
    /// Forces the user through household selection flow before using main app features.
    func requireHouseSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .main
            requiresHouseSelection = true
            setNavigation(tab: .home, routes: [])
        }
    }
    
    /// Applies a new household context, clears volatile in-memory state, and returns to Home root.
    func switchHouse(to house: House) {
        withAnimation(.easeInOut(duration: 0.3)) {
            applyResolvedHouseContext(house)
            setNavigation(tab: .home, routes: [])
        }
        Task {
            do {
                guard let user = try await userProvider.current() else { return }
                _ = try await profileSyncRepository.setLocalSelectedHousehold(for: user.id, houseId: house.id)
            } catch {
                globalProfileErrorMessage = "Could not persist selected house locally."
            }
        }
    }
    
    func navigate(to route: AppRoute) {
        append(route, to: selectedTab)
    }
    
    func navigateBack() {
        switch selectedTab {
        case .home:
            guard !homeNavigationPath.isEmpty else { return }
            homeNavigationPath.removeLast()
        case .profile:
            guard !profileNavigationPath.isEmpty else { return }
            profileNavigationPath.removeLast()
        }
    }
    
    func popToRoot() {
        resetPath(for: selectedTab)
    }
    
    func setNavigation(tab: AppTab, routes: [AppRoute]) {
        selectedTab = tab
        resetPath(for: tab)
        for route in routes {
            append(route, to: tab)
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
        homeExpiredBadgeCount = 0
        homeNavigationPath = NavigationPath()
        profileNavigationPath = NavigationPath()
    }
    
    private func clearVolatileHouseScopedState() {
        homeNavigationPath = NavigationPath()
        profileNavigationPath = NavigationPath()
    }

    private func append(_ route: AppRoute, to tab: AppTab) {
        switch tab {
        case .home:
            homeNavigationPath.append(route)
        case .profile:
            profileNavigationPath.append(route)
        }
    }

    private func resetPath(for tab: AppTab) {
        switch tab {
        case .home:
            homeNavigationPath = NavigationPath()
        case .profile:
            profileNavigationPath = NavigationPath()
        }
    }

    private func applyResolvedHouseContext(_ house: House) {
        selectedHouse = house
        clearVolatileHouseScopedState()
        houseSessionID = UUID()
        requiresHouseSelection = false
    }

    private func startProfileObservationIfNeeded() {
        Task {
            guard let user = try? await userProvider.current() else {
                observedProfileUserID = nil
                profileObservationTask?.cancel()
                profileObservationTask = nil
                return
            }

            if observedProfileUserID == user.id, profileObservationTask != nil {
                return
            }

            observedProfileUserID = user.id
            profileObservationTask?.cancel()
            profileObservationTask = Task { [weak self] in
                guard let self else { return }
                let stream = await self.profileSyncRepository.observeRecord(for: user.id)
                for await record in stream {
                    guard !Task.isCancelled else { break }
                    await self.handleProfileRecordUpdate(record, userId: user.id)
                }
            }
        }
    }

    private func handleProfileRecordUpdate(_ record: ProfileSyncRecord?, userId: String) async {
        guard let record else { return }
        let profile = record.profile
        applyAppearancePreference(profile.appearancePreference)

        if let selectedHouse, profile.householdIds.contains(selectedHouse.id) == false {
            let removedHouseName = selectedHouse.name
            self.selectedHouse = nil
            houseSessionID = UUID()

            if requiresHouseSelection == false {
                globalProfileErrorMessage = "Your selected house (\(removedHouseName)) is no longer available."
            }

            requireHouseSelection()
            return
        }

        guard selectedHouse == nil,
              requiresHouseSelection == false,
              let lastSelectedHouseID = profile.lastSelectedHouseholdId,
              profile.householdIds.contains(lastSelectedHouseID) else {
            return
        }

        if let household = try? await houseDomainModule.loadHouseholds.execute(
            id: lastSelectedHouseID,
            policy: .localFirst
        ) {
            applyResolvedHouseContext(House(moduleHousehold: household))
        } else {
            _ = try? await profileSyncRepository.setLocalSelectedHousehold(for: userId, houseId: nil)
        }
    }

    func applyAppearancePreference(_ preference: ProfileAppearancePreference) {
        appearancePreference = preference
        UserDefaults.standard.set(preference.rawValue, forKey: appearancePreferenceDefaultsKey)
    }
}
