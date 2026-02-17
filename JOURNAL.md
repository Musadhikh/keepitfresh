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
- Added a new local Swift package at `Packages/HouseModule` for non-UI household domain logic using strict constructor injection (storage + network), with repository/use-case architecture and passing package tests.
- Implemented full house-selection gate flow: authenticated launch and post-login now force a non-dismissible house picker; profile can open house management with create+native switch prompt; switching now fetches fresh house data, resets in-memory context, refreshes session state, and pops navigation back to Home.
- Refactored household create/load orchestration out of `HouseSelectionViewModel` into use cases and modules: `HouseModule` now handles local sync state transitions (`pending/failed/synced`) with a mock in-memory DB during create/fetch, and a new profile sync module mirrors the same stateful local→remote update flow when appending household IDs to profile data.
- Added `Documentation/CREATE_HOUSE_FLOW.md` to document the full create-house orchestration, sync-state transitions, module boundaries, and future DB replacement strategy.
- Added a new local Swift package `Packages/CameraModule` with camera capture + scanner UI (`CameraScanner`) based on `design/initial.pen`, including capture/album/flash/cancel/thumbnail-stack/fullscreen carousel flows, low-light flash auto-enable, haptic success feedback, and typed capture results (`UIImage`, `boundingBox`, `imageSize`, `UUID`).
- Updated `keepitfresh/Info.plist` with camera and photo library usage descriptions required for the new capture and album flows.
- Verified app build after camera changes using `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' -derivedDataPath /tmp/keepitfresh-dd build` (`BUILD SUCCEEDED`).
- Fixed strict concurrency compile failures after adding `CameraModule` to app SPM dependencies by avoiding cross-actor capture of `AVCapturePhoto` in the delegate callback and marking `CameraCapturedImage` as `@unchecked Sendable` for continuation handoff; re-verified with `xcodebuild ... -quiet build` (`BUILD SUCCEEDED`).
- Added a floating camera action button on Home that presents `CameraScannerView`, then automatically presents `AnlayserResultView` on capture completion while passing the full captured image array; result screen currently shows a loading state and captured image count.
- Verified builds with `xcodebuild` after major UI/theme updates (`BUILD SUCCEEDED`).

## 2026-02-16
- Refactored `keepitfresh/Presentation/Product/ProductOverView.swift` to match the `Item Detail` design from `design/initial.pen`: custom header, hero image card with pager dots, status chip, barcode/dates/category/detail cards, and bottom discard/save action bar.
- Extended `keepitfresh/App/Theme.swift` `Theme.Icon` with product-overview icon tokens and wired the new screen to `Image(icon:)` usage (no hardcoded symbol strings in the view).
- Upgraded `keepitfresh/Presentation/Product/ProductOverViewModel.swift` with UI-facing state for generation progress, error/status text, image pager selection, category/date formatting, and detail row composition from generated product fields.
- Verified the app compiles with `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build -quiet` (`BUILD SUCCEEDED`).
