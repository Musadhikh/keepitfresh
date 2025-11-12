# KeepItFresh — Auth Flow Instruction for CodeGen (Codex/Xcode)

> **Purpose**  
> Generate a **backend-agnostic** login flow that:  
> 1) Authenticates with a selected provider, 2) Ensures a user profile exists (create if missing), 3) Returns a **NextStep** that hands off to a future Household flow (not implemented here).

> **Target stack**  
> Swift 6, Xcode 26, Clean Architecture (Domain → Data → Presentation), Swift Concurrency, `@Observable` where needed.  
> **Strict constraint:** No Firebase or vendor SDK types in Domain/Presentation. All vendor code (if any later) lives behind **Ports** in Data.

---

## ✅ Scope (Generate These)

- Directory structure, empty folders, and implementation files.
- **Domain**:
  - Entities: `Identity`, `UserProfile`, `NextStep`, `AuthError`.
  - Ports (protocols): `AuthenticationPort`, `ProfilePort`.
  - Use cases: `LoginWithProvider`, `EnsureProfileAfterAuth`, `BootstrapOnLaunch`, `Logout`.
- **Data**:
  - Placeholders/adapters only: `InMemoryAuthAdapter` and `InMemoryProfileAdapter` (for now).
- **Presentation**:
  - A simple headless orchestrator (no UI) that demonstrates the flow and returns `NextStep`.
  - Minimal `AppState` slice to hold `(identity, profile)` during the handoff.
- **Tests**:
  - Unit tests for success/error branches of the use cases with mock ports.

**Non-Goals**: Household flow, UI screens, vendor auth (Firebase/Google/Apple), forgotten password.

---

## 🗂️ Project Structure (Create These Paths & Files)

```
KeepItFresh/
  Domain/
    Authentication/
      Models/
        Identity.swift
        UserProfile.swift
        NextStep.swift
        AuthError.swift
      Ports/
        AuthenticationPort.swift
        ProfilePort.swift
      UseCases/
        LoginWithProvider.swift
        EnsureProfileAfterAuth.swift
        BootstrapOnLaunch.swift
        Logout.swift
  Data/
    Authentication/
      Adapters/
        InMemoryAuthAdapter.swift
        InMemoryProfileAdapter.swift
  Presentation/
    AuthOrchestrator/
      AuthCoordinator.swift
    App/
      AppState.swift
  Tests/
    DomainAuthTests/
      LoginWithProviderTests.swift
      EnsureProfileAfterAuthTests.swift
      BootstrapOnLaunchTests.swift
```

---

## 📚 Domain Models (Implement Exactly As Described)

### Identity
- Fields:  
  - `userId: String` (nonempty)  
  - `authMethod: AuthMethod` (enum: `.email`, `.apple`, `.google`, `.guest`, `.other(String)`)  
  - `isGuest: Bool`
- Conformances: `Equatable`, `Sendable`, `Codable`

### UserProfile
- Fields:  
  - `userId: String`  
  - `displayName: String?`  
  - `email: String?`  
  - `createdAt: Date`
- Conformances: `Equatable`, `Sendable`, `Codable`

### NextStep
- Enum with associated values:
  - `.startHouseholdFlow(userId: String, profile: UserProfile)`
  - `.needsLogin` (used by `BootstrapOnLaunch` only)
- Conformances: `Equatable`, `Sendable`

### AuthError
- Enum cases:
  - `cancelled`, `invalidCredentials`, `network`, `unavailable`, `unknown(String)`
- Conformances: `Error`, `Equatable`, `Sendable`

---

## 🔌 Ports (Protocols) — **No vendor leakage**

### AuthenticationPort
- `func availableProviders() -> [ProviderInfo]`
  - `ProviderInfo`: `{ id: String, displayName: String, isGuest: Bool }`
- `func authenticate(providerId: String, context: [String: String]?) async throws -> Identity`
- `func currentIdentity() async -> Identity?`
- `func logout() async throws`

### ProfilePort
- `func getProfile(userId: String) async throws -> UserProfile?`
- `func createProfile(userId: String, seed: [String: String]?) async throws -> UserProfile`

> **Note**: All async APIs; throw `AuthError` for auth-related failures and `unknown` for others.

---

## 🧠 Use Cases (Pure, Stateless)

### LoginWithProvider
- Input: `providerId: String`, `context: [String: String]?`
- Behavior: call `AuthenticationPort.authenticate`; return `Identity`
- Errors: surface port errors unchanged.

### EnsureProfileAfterAuth
- Input: `userId: String`, optional `seed: [String: String]? = nil`
- Behavior: read via `ProfilePort.getProfile`; if nil → `createProfile`
- Output: `UserProfile`

### BootstrapOnLaunch
- Behavior:
  - `AuthenticationPort.currentIdentity()`  
    - `nil` → return `.needsLogin`
    - some(identity) → run **EnsureProfileAfterAuth** → return `.startHouseholdFlow(userId, profile)`

### Logout
- Behavior: `AuthenticationPort.logout()`  
- Side effect: caller should reset state; no return value.

---

## 🎛️ Orchestration (Presentation, no UI)

Create `AuthCoordinator` that wires the minimal happy path:

```
func loginThenHandoff(providerId: String, context: [String:String]? = nil) async throws -> NextStep
  1) identity = try await LoginWithProvider.execute(providerId, context)
  2) profile  = try await EnsureProfileAfterAuth.execute(identity.userId, seed: nil)
  3) return .startHouseholdFlow(userId: identity.userId, profile: profile)
```

And a cold-launch variant:

```
func bootstrap() async throws -> NextStep
  switch await AuthenticationPort.currentIdentity():
    case nil: return .needsLogin
    case some(identity):
       let profile = try await EnsureProfileAfterAuth.execute(identity.userId, seed: nil)
       return .startHouseholdFlow(userId: identity.userId, profile: profile)
```

---

## 🧩 Data Layer (Temporary In-Memory Adapters)

Implement lightweight, dependency-free adapters to make tests and previews pass:

### InMemoryAuthAdapter
- Store: `var identity: Identity?`
- `availableProviders()` → at least `email`, `apple`, `google`, `guest`
- `authenticate(providerId, context)`:
  - If `providerId == "guest"` → create `Identity(isGuest: true)`
  - Else → create `Identity(isGuest: false)`
- `currentIdentity()` → return stored identity
- `logout()` → set identity to `nil`

### InMemoryProfileAdapter
- Store: `[userId: UserProfile]`
- `getProfile(userId)` → lookup
- `createProfile(userId, seed)` → insert default profile if missing

> These are **not** production. They exist to keep the Domain flow runnable and testable.

---

## 🧪 Tests (Essential Matrix)

Create unit tests using the in-memory adapters or mocks:

1) **LoginWithProviderTests**
   - success guest/email → returns `Identity`
   - cancelled → throws `.cancelled`
   - invalid credentials → throws `.invalidCredentials`

2) **EnsureProfileAfterAuthTests**
   - existing profile → returns it (no creation)
   - missing profile → creates once and returns

3) **BootstrapOnLaunchTests**
   - no identity → `.needsLogin`
   - identity present + profile exists → `.startHouseholdFlow(...)`
   - identity present + profile missing → create then `.startHouseholdFlow(...)`

---

## 🧭 Coding & Style Constraints

- Swift 6, `Sendable` correctness; avoid `@unchecked Sendable` unless necessary.
- Use `struct` for models; no reference semantics in Domain.
- Use `final class` only for adapters/coordinators.
- No UI components in this task. Orchestrator returns `NextStep` only.
- Map **all** adapter errors to `AuthError` where applicable; anything else → `unknown(String)`.
- **No** hard references to Firebase/Google/Apple SDKs anywhere.
- Keep **ports and use cases** in **Domain**; adapters in **Data**.

---

## 🔧 Dependency Injection (Simple)

- Accept `AuthenticationPort` and `ProfilePort` in use case initializers.
- `AuthCoordinator` receives the use cases (already wired).
- Provide a tiny `CompositionRoot` (optional) that wires in the in-memory adapters for a runnable demo.

---

## 📝 Observability (Optional Hooks)

- Emit lightweight callbacks (no analytics SDK):  
  `auth_login_started`, `auth_login_success`, `auth_login_failed`, `profile_created`, `profile_loaded`.  
  Implement as no-ops or simple `print` statements for now.

---

## ✅ Acceptance Criteria

- After `loginThenHandoff`, result is always `.startHouseholdFlow(userId, profile)` on success.
- After `bootstrap`, result is `.needsLogin` or `.startHouseholdFlow(...)` depending on session.
- No vendor imports. All logic is provider-neutral.
- Tests passing for the defined matrix.

---

## 🔚 Deliverable

- All files created per structure above with complete implementations.
- Public APIs documented with brief doc comments.
- Zero compiler warnings (`-Wall` equivalent), Swift 6 concurrency warnings addressed.

---

## 🚀 Execution Notes for Codex

1. **Create the folders and files exactly as listed.**
2. **Implement Domain models/enums first**, then Ports, then Use Cases.
3. **Implement in-memory adapters** under Data.
4. **Implement the `AuthCoordinator`** orchestration functions.
5. **Add unit tests** and make them pass with the in-memory adapters.
6. **Do not** add any Firebase/Google/Apple code; no UI screens.

> When done, print a short summary of created files and how to invoke `AuthCoordinator.loginThenHandoff(providerId:)` in a playground to see `.startHouseholdFlow(...)`.
