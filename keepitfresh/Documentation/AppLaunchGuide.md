# App Launch Feature Guide

This document explains how the KeepItFresh app determines the correct screen to show after launch, what each component is responsible for, and how to extend or test the flow. Use it as a reference when working on the splash/onboarding experience or whenever app initialization rules change.

## What the Feature Does

The app-launch feature guarantees that every cold start or relaunch evaluates the user’s eligibility to enter the main experience. It refreshes remote metadata, enforces maintenance/version policies, validates authentication, and inspects household context to decide whether to show a maintenance screen, force an update, prompt login, request household creation/selection, or proceed directly to the main content. All of this logic runs before leaving the splash screen so the user transitions seamlessly to the correct destination without manual interaction.

## High-Level Flow

1. `SplashView` appears immediately and triggers `SplashViewModel.start()` once.
2. `SplashViewModel` calls `AppLaunchUseCase.execute()` while enforcing a minimum splash duration.
3. `AppLaunchUseCase` orchestrates metadata, version, user, and profile checks to produce an `AppLaunchState`.
4. `SplashView` listens for the resulting `launchState` and drives `AppState` to route the UI.

```
SplashView → SplashViewModel → AppLaunchUseCase
            ↑                  ↓
        AppState ← AppLaunchState ← Providers
```

## Core Components

| Layer | File | Responsibility |
| --- | --- | --- |
| Domain | `Domain/UseCases/AppLaunch/AppLaunchUseCase.swift` | Pure business rules that decide which `AppLaunchState` to return. No UI logic. |
| Domain | `Domain/UseCases/AppLaunch/AppLaunchState.swift` | Enum representing every routing outcome the launcher can emit. |
| Presentation | `Presentation/Splash/SplashViewModel.swift` | Async coordinator that calls the use case, tracks loading state, caches errors, and exposes the resulting `AppLaunchState`. |
| Presentation | `Presentation/Splash/SplashView.swift` | Animated splash UI that reacts to `launchState` updates and requests navigation via `AppState`. |
| App Layer | `App/AppState.swift` | Global observable state that defines top-level shells (`.splash`, `.authentication`, `.main`). |
| Composition | `App/AppDependencyContainer.swift` | Builds concrete provider instances and exposes the `AppLaunchUseCase`. Replace stub providers here when real data sources exist. |
| Composition | `App/KeepItFreshApp.swift` | Creates the dependency container once, injects the shared `SplashViewModel`, and renders `SplashView`. |

## Detailed Execution Steps

`AppLaunchUseCase.execute()` (`AppLaunchUseCase.swift`) performs the following in order:

1. **Metadata refresh** – `AppMetadataProviding.getAppMetadata()` supplies remote flags/message.
2. **Maintenance gate** – If `isUnderMaintenance` the use case returns `.maintenance`.
3. **Version enforcement** – `VersionCheckProviding.requiresVersionUpdate(metadata:)` decides if an update is mandatory and returns `.updateRequired` when true.
4. **Authentication** – `UserProviding.current()` returning `nil` maps to `.loginRequired`.
5. **Session validation** – `UserProviding.validateSession()` ensures tokens are still valid.
6. **Profile refresh** – `UserProfileProviding.getUserProfile(for:)` fetches contextual information.
7. **Household routing**:
   - No `householdIds` → `.createHousehold`
   - Missing `lastSelectedHouseholdId` → `.selectHousehold`
8. **All clear** – Reaching the end means the app can enter `.mainContent`.

Every branch is synchronous from the caller’s perspective since the use case returns the state instead of throwing, which keeps UI routing logic straightforward.

## UI Integration

- `SplashViewModel` exposes `launchState`, `launchError`, `isLoading`, and `shouldNavigate`. It prevents duplicate launches via the `hasStarted` flag and always enforces a 2-second splash duration so the animation has time to play.
- `SplashView` injects a concrete `SplashViewModel` and:
  - Starts animations inside `onAppear`.
  - Calls `await viewModel.start()` via `.task`.
  - Observes `viewModel.launchState` and routes:
    - `.loginRequired` → `appState.requireAuthentication()`
    - `.mainContent` → `appState.enterMain()`
    - Other cases are placeholders for future dedicated screens (maintenance banner, forced update sheet, household flows, etc.).

Because routing happens through `AppState`, downstream coordinators remain isolated from splash-specific logic.

## Dependency Injection Path

1. `KeepItFreshApp` owns a single `AppDependencyContainer` for the entire app lifecycle.
2. The container currently wires in stub providers (`StaticAppMetadataProvider`, `StaticVersionCheckProvider`, etc.). Swap these with real implementations as the Data layer matures.
3. `KeepItFreshApp` creates one `SplashViewModel` using the container’s `appLaunchUseCase` and injects it into `SplashView`.

This approach keeps SwiftUI previews simple—`SplashView` uses `.preview` helpers that resolve their dependencies through the same container.

## Extending the Flow

- **New launch checks**: Add the logic inside `AppLaunchUseCase.execute()` and introduce a new `AppLaunchState` case. Update `SplashView` (or a future coordinator) to respond to the new state.
- **Dedicated maintenance/update UI**: Create specialized SwiftUI screens and have `SplashView` push them by extending the `handleLaunchState` switch.
- **Telemetry**: Hook analytics inside `SplashViewModel.performInitializationTasks()` after the use case resolves.
- **Retry support**: Use `launchError` to display a retry CTA while staying on the splash screen if network failures occur.

## Testing Tips

1. **Unit-test the use case** by mocking each provider protocol. Cover every branch to guarantee routing is deterministic.
2. **View model tests** can inject a fake use case that returns predetermined states to ensure `launchState` propagates correctly and the minimum splash duration is honored.
3. **Snapshot/UI tests** should confirm that `SplashView` transitions to the proper `AppState` when the view model publishes each state.

Run tests with the standard scheme:

```bash
xcodebuild test -project keepitfresh.xcodeproj -scheme keepitfresh -destination 'platform=iOS Simulator,name=iPhone 15'
```

Add new tests under `keepitfreshTests` that target `AppLaunchUseCase` and `SplashViewModel` as the feature evolves.
