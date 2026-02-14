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
- Verified builds with `xcodebuild` after major UI/theme updates (`BUILD SUCCEEDED`).
