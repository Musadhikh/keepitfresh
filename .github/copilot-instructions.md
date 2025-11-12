# KeepItFresh – Copilot Instructions

## Project Overview
KeepItFresh is an iOS/iPadOS/macOS app for tracking food inventory and expiry dates. Built with Swift 6, SwiftUI, and Firebase backend, following Clean Architecture with strict protocol-first design.

**Tech Stack:** Swift 6 (min iOS 18.0) • SwiftUI • Firebase (Auth, Firestore) • Google Sign-In • Swift Package Manager

## Architecture

### Clean Architecture Layers
The codebase strictly separates concerns into four layers:

**Domain Layer** (`keepitfresh/Domain/`)
- Pure business logic with zero framework dependencies
- Contains protocols (`*Providing`), models (`Sendable` structs/enums), and use cases
- Example: `AuthServiceProviding` defines auth interface, `FirebaseAuthService` implements it in Data layer

**Data Layer** (`keepitfresh/Data/`)
- Implements Domain protocols using Firebase/external SDKs
- All services are `actor`-based for thread safety (see `FirebaseAuthService`)
- Naming: `Firebase*Service`, `*Repository`, `*Helper`

**Presentation Layer** (`keepitfresh/Presentation/`)
- SwiftUI views + ViewModels using `@Observable` macro (not ObservableObject)
- ViewModels must be `@MainActor final class` with `@Observable`
- Each feature in own folder: `/Splash`, `/Authentication`, etc.

**Utils Layer** (`keepitfresh/Utils/`)
- Shared constants (`AnimationConstants`, `FirebaseConstants`)
- Extensions (`Logger+Extension`, `Color+Extension`)
- Helpers (`GoogleSignInConfig`)

### Key Patterns

**Protocol-First Design**
```swift
// Domain defines interface with `Providing` suffix
protocol AuthServiceProviding: Sendable {
    func signInWith(provider: AuthProviding) async throws -> AuthUser
}

// Data implements with specific tech (Firebase, Google, etc.)
actor FirebaseAuthService: AuthServiceProviding { ... }
```

**Authentication Flow**
Multi-provider auth uses strategy pattern:
1. `AuthProviding` protocol defines providers (Google, Apple, Email, Anonymous)
2. Each provider returns `AuthCredential` enum
3. `FirebaseAuthService` actor converts credentials and executes sign-in
4. Example: `GoogleSignInHelper.signIn()` → `AuthCredential.google()` → `FirebaseAuthService.signInWith()`

**Concurrency Model**
- All async operations use `async/await` (NO completion handlers)
- Data layer services are `actor`-based for thread safety
- ViewModels are `@MainActor` to ensure UI updates on main thread
- Use `Task.detached` for background Firebase calls (see `FirebaseAuthService.signInWith`)

**App State Management**
`AppState` is the root coordinator using `@Observable`:
```swift
@Observable final class AppState {
    enum State { case splash, authentication, main }
    private(set) var currentState: State = .splash
}
```
Injected via `.environment(appState)` in `KeepItFreshApp.swift`

## Code Conventions

### Naming Standards
| Type | Suffix | Example |
|------|--------|---------|
| Protocol | `Providing` | `HouseProviding` |
| Model | None | `User`, `House` |
| ViewModel | `ViewModel` | `SplashViewModel` |
| View | `View` | `SplashView` |
| Service | `Service` | `FirebaseAuthService` |
| Helper | `Helper` | `GoogleSignInHelper` |
| Repository | `Repository` | `HouseRepository` |

### Swift 6 Specifics
- All models must be `Sendable` (struct/enum preferred over class)
- Use `@Observable` macro (NOT `@ObservableObject/@Published`)
- Protocols crossing concurrency domains need `Sendable` conformance
- ViewModels: `@Observable @MainActor final class`

### Logging
Use categorized loggers from `Logger+Extension`:
```swift
auth.debug("User signed in") // Auth operations
data.error("Failed to fetch", error: error) // Data layer
ui.warning("Invalid input") // UI layer
firebase.debug("Firestore query") // Firebase-specific
```

### Preview Support
- Always provide `#Preview` for SwiftUI views
- Create static `.preview` properties for ViewModels/models in `#if DEBUG` blocks
- Mock functions use `mock` prefix (e.g., `GoogleSignInHelper.mockSignIn()`)

### Error Handling
Domain defines errors as enums:
```swift
enum AuthError: Error, LocalizedError {
    case networkError, invalidCredentials, accountDisabled, userCancel
    case unknownError(String)
}
```
Data layer maps Firebase/SDK errors to domain errors (see `FirebaseAuthService.mapFirebaseError`)

## Development Workflow

### Firebase Configuration
- Firebase initialized in `KeepItFreshApp.init()` with offline persistence (200MB cache)
- Firestore settings: `PersistentCacheSettings` configured for offline-first
- Google Sign-In requires `GoogleService-Info.plist` (excluded from git)

### Testing Approach
- Mock implementations for all `*Providing` protocols
- Use `#if DEBUG` for test helpers and mock functions
- Preview data via static `.preview` properties

### Animation Standards
- Use constants from `AnimationConstants` (e.g., `AnimationConstants.splashIconSpring`)
- Splash screen has minimum 2s display time via `Task.sleep(for:)`
- Animations should use `.animation(_:value:)` modifier, not implicit animations

## Common Tasks

**Adding a New Feature**
1. Create protocol in `Domain/Services/*Providing.swift`
2. Add models in `Domain/Models/`
3. Implement service in `Data/` as `actor`
4. Create ViewModel (`@Observable @MainActor final class`) and View in `Presentation/`

**Adding Auth Provider**
1. Add case to `AuthCredential` enum
2. Create `*AuthProviding` protocol in `Domain/Auth/`
3. Implement helper in `Data/` with `@MainActor` if needs UI
4. Add mapping in `AuthCredential+Extension`

**Firebase Operations**
- Always wrap in `Task.detached` when called from actor context
- Configure offline persistence in app init
- Use constants from `FirebaseConstants` for cache settings

## Files to Reference
- Architecture example: `keepitfresh/Data/FirebaseAuth/FirebaseAuthService.swift`
- ViewModel pattern: `keepitfresh/Presentation/Splash/SplashViewModel.swift`
- Protocol design: `keepitfresh/Domain/Auth/AuthServiceProviding.swift`
- Multi-provider auth: `keepitfresh/Data/GoogleAuth/GoogleSignInHelper.swift`
- App state flow: `keepitfresh/App/AppState.swift`
