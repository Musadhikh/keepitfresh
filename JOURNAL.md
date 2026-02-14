# Journal

## 2026-02-15
- Reviewed and applied local skill guidance (`swiftui-expert-skill`) for UI refactoring quality.
- Updated splash UI to align with `design/initial.pen` structure and theme tokens for light/dark support.
- Added app theme tokens for color and typography in `keepitfresh/App/Theme.swift`.
- Standardized file header template for Codex-created files per requested format.
- Centralized SF Symbol names under `Theme.Icons` and replaced hardcoded icon strings across views.
- Reworked icon tokens to a typed `Theme.Icon` enum and added `Image(icon:)` extension for direct enum usage in SwiftUI.
- Added root `REQUIREMENTS.md` to persist coding/UI conventions (headers, theming, icons, journal workflow, and build verification).
- Moved requirement conventions to root `AGENTS.md` and removed `REQUIREMENTS.md` per project workflow update.
- Expanded `AGENTS.md` with global Codex documentation rules, `JOURNAL.md` expectations, writing style guidance, update triggers, and Swift/Xcode conventions.
- Added explicit skill enforcement rules in `AGENTS.md` so listed skills must be used whenever named or clearly relevant.
- Replaced the previous generic Swift/Xcode convention block in `AGENTS.md` with the full Senior iOS Swift/SwiftUI/SwiftData guide and removed overlapping duplicate convention requirements.
- Fixed Splash Dynamic Type behavior by switching theme font builders to `relativeTo`-based scaling and scaling splash badge/icon sizing with `@ScaledMetric`.
- Added an upper Dynamic Type cap on splash (`.dynamicTypeSize(... .accessibility2)`) to prevent layout breakage at very large text sizes.
- Updated `AGENTS.md` with a permanent rule to cap Dynamic Type on constrained screens when maximum accessibility sizes would break layout.
- Refactored `keepitfresh/Presentation/Login/LoginView.swift` from `design/initial.pen` auth screen: rebuilt header/card structure, mapped pen spacing/radius tokens, added themed dark/light-safe button surfaces, and aligned sign-in actions with available auth methods.
- Fixed light-mode visibility for the Google sign-in button by switching to plain button rendering and increasing fill/border contrast inside the auth card.
- Matched Google button visual polarity to Apple button behavior: light mode uses dark surface with light text, dark mode uses light surface with dark text.
- Tuned Google button title styling to better match Apple sign-in presentation by using Apple-like casing and system headline sizing.
- Center-aligned the login auth section vertically with a geometry-aware scroll layout so `LoginAuthCard` stays centered on larger screens without breaking small-screen scrolling.
- Repaired Apple sign-in UI stability by removing transient placeholder states and introduced one shared dynamic auth button height (with a cap) so Apple/Google/Email/Guest buttons keep equal sizing.
- Made Apple nonce generation non-optional with a secure fallback path so sign-in UI stays stable even when secure random bytes are unavailable.
- Completed login-to-app handoff flow: login now returns a launch next-step, `AppState` applies shared routing for splash/login, and household-required states now navigate into the household selection route instead of silently landing on root.
- Updated bootstrap behavior to auto-create missing user profiles for authenticated sessions, avoiding false login-required loops after successful auth.
- Added `Error` extension helpers (`nsError`, `errorCode`, `errorDomain`, reason/suggestion`) so error-code handling is centralized without manual `NSError` casting at call sites.
- Aligned DI style with Factory README guidance by moving login use case back to `@Injected` field-based resolution and documented project-level Factory rules in `AGENTS.md` (including no-default-args guidance for constructors/methods).
- Verified builds with `xcodebuild` after major UI/theme updates (`BUILD SUCCEEDED`).
