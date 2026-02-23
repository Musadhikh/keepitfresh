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

## 2026-02-18
- Migrated `HomeView` analyzer flow from captured-image completion to VisionKit scan completion (`[RecognizedItem]`) so navigation to `ProductOverView` is triggered by `DataScannerViewController` results.
- Refactored `ProductOverViewModel` to parse text/barcode payloads directly from `RecognizedItem`, generate product output from `RecognizedData`, and expose scan-summary state (item/text/barcode counts + preview rows).
- Updated `ProductOverView` to replace the image hero card with a scan summary card that reflects VisionKit output while preserving the existing item-detail layout style.
- Verified compile success with `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build -quiet` (`BUILD SUCCEEDED`).

## 2026-02-19
- Added a dedicated local Swift package at `Packages/BarcodeScannerModule` for live barcode scanning with VisionKit (`DataScannerViewController`) and a clean public API (`BarcodeScannerView`, `ScannedBarcode`, scanner configuration/availability models).
- Tuned scanner UX for responsiveness: stable controller lifecycle (no restart on SwiftUI updates), immediate callback delivery, duplicate-event cooldown gating, lightweight debounce for continuous mode, and built-in haptic confirmation on successful scans.
- Integrated the module into `HomeView` with a new “Scan Barcode” quick action and instant dismiss-on-detection flow, plus a “Latest Barcode” section to surface the most recent scan payload/symbology.
- Added focused unit tests in `Packages/BarcodeScannerModule/Tests/BarcodeScannerModuleTests/BarcodeEmissionGateTests.swift` to validate duplicate suppression behavior in the scan emission gate.
- Verified app build with `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`).

## 2026-02-20
- Built a large-scale OpenFoodFacts Firestore ingestion pipeline (`openfoodfacts/firestore_importer.py`) that streams JSONL safely (line-by-line, batched commits, resumable checkpoints), with barcode enforced as the product document ID.
- Restructured product image handling so image metadata now lives under `productDetails.images` as a grouped dictionary (`direct`, `selected`, and OFF image IDs), while preserving `imageUrl` as a primary convenience field.
- Added automatic category graph maintenance during import: `OpenFoodFactsCategories` documents are created/updated with parent-child relationships to model categories and subcategories.
- Added `openfoodfacts/README.md` and `openfoodfacts/requirements.txt` with operational runbook details (dry run, real import, filtering, category toggles, and cost cautions).
- Added `openfoodfacts/DAILY_IMPORT_RUNBOOK.md` with a day-by-day quota-safe resume playbook (checkpoint continuity, anti-duplicate guarantees, background run command, monitoring commands, and quota-exceeded recovery steps).
- Extended Firestore constants with `openFoodFactsProducts` and `openFoodFactsCategories` so app-side usage remains centralized and typo-safe.
- Re-architected product modeling into a strict Domain vs AI split: added stable Firestore/UI domain models (`Product`, `ProductDetails`, discriminator-based `ProductDetailsPayload`, common/detail structs), parallel `@Generable` extraction models for 3-pass LLM extraction, and dedicated mappers from extraction output to domain documents.
- Added Firestore codable/path helpers for product base + details subcollection patterns, including timestamp normalization and document-id injection when decoding product documents.
- Updated extraction pipeline compatibility by switching generator output from legacy `@Generable Product` to `ProductBaseExtraction`, and adjusted product overview references to the new extraction model names.
- Verified compile success with `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build -quiet` (`BUILD SUCCEEDED`).
- Scaffolded the new `AddProduct` module end-to-end (Domain/Data/Presentation/DI), reusing existing shared models where possible (`Barcode`, `ProductDateInfo`) via Add Product aliases/extensions instead of duplicating core domain types; build re-verified with `xcodebuild ... build -quiet` (`BUILD SUCCEEDED`). Test run surfaced pre-existing unrelated compile failures in `keepitfreshTests/AppLaunchUseCaseBuilder.swift` (missing `UserProfile` and outdated `Injected` argument expectations), so Add Product tests are present but the test target currently cannot compile without fixing those baseline test issues first.

## 2026-02-22
- Added a debug Firestore mock layer (`keepitfresh/Data/FirebaseServices/FirestoreDebugMockServices.swift`) with a shared in-memory store and mock providers for app metadata, profiles, and houses, then switched Factory registrations to these mocks in `DEBUG` so Firestore-backed requests are automatically intercepted during debug builds.
- Updated app bootstrap to skip Firestore runtime cache configuration in `DEBUG` while keeping production behavior unchanged (`KeepItFreshApp` still configures Firestore in non-debug builds).
- Verified debug compile success with `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build -quiet` (`BUILD SUCCEEDED`).
- Connected Add Product flow to Home: added an explicit “Add Product” quick action and switched the floating CTA to open `AddProductFlowRootView` in a full-screen cover, using current selected household ID as the default context for the module assembler. Kept camera analyzer flow accessible via a dedicated “Scan Images” quick action. Re-verified with `xcodebuild ... build -quiet` (`BUILD SUCCEEDED`).
- Switched Add Product navigation from modal presentation to push navigation: Home now routes through `AppRoute.addProduct`, and `RootTabView` resolves that route in `navigationDestination`, so the flow is pushed from Home with normal back-stack behavior. Added deep-link support for `keepitfresh://home/add-product`. Re-verified with `xcodebuild ... build -quiet` (`BUILD SUCCEEDED`).
- Refined Add Product entry flow to use real scanning from Home: Home “Add Product” and “Scan Barcode” now open `BarcodeScannerView`, and successful scan immediately pushes Add Product route with the scanned payload/symbology as input. Removed in-module mock scan button from `BarcodeScannerScreen` so there is no fake barcode path in Add Product scanning.
- Added a global Firebase write toggle (`FirebaseWritePolicy.isMockWriteEnabled`, default `true`) to mock write operations while keeping reads live. `ProfileFirebaseService` and `HouseFirebaseService` now short-circuit writes to an in-memory mock store when enabled, and use that store as read fallback for mocked records. Re-enabled normal Firestore initialization in app startup and verified with `xcodebuild ... build -quiet` (`BUILD SUCCEEDED`).
- Removed mock image data from Add Product capture fallback by replacing “Add Mock Image” with `PhotosPicker`-based real image selection (1–3 images), so the add-product scan/capture path now uses real user input end-to-end.
- Added a new local Swift package `Packages/RealmDatabaseModule` to provide a clean-architecture Realm persistence layer: domain-facing async repository contracts + mapping protocol (`RealmModelConvertible`) and an actor-isolated generic implementation (`RealmObjectRepository`) that accepts non-Realm models, maps them into Realm objects, and performs CRUD safely.
- War-story bug: test crashes exposed two subtle Realm gotchas. First, setting `fileURL = nil` after an in-memory identifier silently invalidated the config; fixed by only applying `fileURL` when non-nil. Second, relying on `ObjectType.primaryKey()` was flaky for some Swift test object declarations; switched to schema-based primary-key detection from the opened `Realm` instance.
- Verified package quality with `swift build --package-path keepitfresh/Packages/RealmDatabaseModule` and `swift test --package-path keepitfresh/Packages/RealmDatabaseModule` (all tests passing).
- Switched profile sync local persistence from ephemeral memory to Realm by adding `RealmProfileStorageService` and a dedicated `ProfileSyncRecordObject` mapper (`ProfileSyncRecord` <-> Realm object). This keeps `Profile` as a clean domain struct while making profile-sync state durable across app restarts. Factory DI now resolves `ProfileStorageServicing` to Realm storage instead of the in-memory implementation.
- Tightened architecture boundary after review: removed `ProfileSyncRecordObject` and all `RealmSwift` references from the app target. The conversion now lives fully inside `RealmDatabaseModule` through `RealmCodableRepository<Model>`, so app code passes only domain `Codable` models (`ProfileSyncRecord`) and key selectors. Re-verified with package tests + app build.
- Implemented a full offline-first profile sync engine in `ProfileSyncRepository`: local profile is now the startup source of truth, remote sync runs in the background, and local/remote conflicts are merged with a three-way strategy (base/local/remote) including household membership reconciliation. Added live profile observation streams so `HouseSelectionViewModel`, `ProfileViewModel`, and `AppState` react to sync updates in real time.
- App launch and login now use `AppLaunchDecision` (state + optional selected house) instead of state-only routing. Launch flow now restores a valid locally selected house when possible and skips house selection; if the selected house later gets removed by a profile update, `AppState` forces house re-selection and surfaces a user-facing error.
- Enforced local-only semantics for `lastSelectedHouseholdId`: remote adapter (`ProfileRemoteServiceAdapter`) strips local-only fields on create/update/fetch, so backend profile data only contains shared profile fields while local selection remains device-scoped.
- Crash fix war-story: injecting Firebase-backed dependencies directly as stored `@Injected` properties inside `AppState` caused premature `Firestore.firestore()` access before `FirebaseApp.configure()`, triggering `FIRIllegalStateException` on launch. Fixed by switching `AppState` dependencies to lazy `Container.shared...` computed properties so resolution happens only after app bootstrap.

## 2026-02-23
- Added a new local Swift package `Packages/ImageDataModule` that mirrors the existing image-data domain/service design (`AIDataGenerating`, `VisionExtracting`, `ExtractedData` model graph, prompt/instruction types, Vision extractor, FoundationModels generator) so image extraction/generation logic is now modularized and reusable.
- Added package-level tests (`ImageDataModuleTests`) for baseline API behavior, including `ModelStringConvertible` output and `ExtractedData` initialization wiring.
- Refined the captured-image contract in the module to be platform-neutral (`CGImage` + `CGImagePropertyOrientation`) with a UIKit convenience initializer, which avoids hard-binding the package core to UI-only image types while preserving iOS integration ergonomics.
- Verification: `swift build --package-path keepitfresh/Packages/ImageDataModule` (`BUILD SUCCEEDED`) and `swift test --package-path keepitfresh/Packages/ImageDataModule` (2 tests passed, 0 failures).
- Rebuilt `Presentation/Product/AddProduct/ProductReviewView` from `design/screen.png` into a fully scrollable, card-based review UI (hero image, overlay summary card, metric tiles, nutrition + household sections, and bottom add CTA) with smooth tokenized spacing/padding throughout.
- Wired the screen data directly to `ProductReviewViewModel.generatedData` (`ExtractedData.PartiallyGenerated`) with safe fallbacks for title/category/barcode/unit/dates/nutrition/storage fields, and added explicit in-view `TODO` markers for missing structured extraction fields (quality claims and dedicated unit field).
- Verification: `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`).
