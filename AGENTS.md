# KeepItFresh Requirements

This document defines project conventions that must be followed in future updates.

## 1) File Header Template (Swift files)
Use this header for every new Swift file:

```swift
//
//  <FileName>.swift
//  keepitfresh
//
//  Created by musadhikh on <D/M/YY>.
//  Summary: <one-line purpose of the file>.
//
```

Rules:
- Keep the `Summary` line mandatory for files created/updated by Codex.
- Match filename and project name exactly.
- Use the current date when creating the file.

## 2) Theming Requirements
All UI styling should use tokens from `Theme` in `keepitfresh/App/Theme.swift`.

Required usage:
- Colors: `Theme.Colors.*`
- Fonts: `Theme.Fonts.*`
- Radius: `Theme.Radius.*`
- Spacing: `Theme.Spacing.*`

Avoid:
- New hardcoded colors, font sizes, spacing, and corner radii unless explicitly approved.

## 3) Icon Requirements
Centralized icon source:
- `Theme.Icon` enum in `keepitfresh/App/Theme.swift`
- `Image(icon:)` extension in `keepitfresh/Utils/Extensions/Image+Extension.swift`

Required usage:
- For images: `Image(icon: .someCase)`
- For APIs needing `String` (for example `Label(..., systemImage:)`): `Theme.Icon.someCase.systemName`

Avoid:
- Hardcoded SF Symbol strings in views.

## 4) Design Source Requirements
When implementing or updating visual UI, align with:
- `design/initial.pen`

Apply both light and dark mode through theme tokens (do not duplicate hardcoded light/dark colors in views).

## 5) Journal Requirement
Keep a running journal in `JOURNAL.md`.

Required:
- Append a short bullet entry for each meaningful implementation change.
- Include build/test verification outcomes when run.

## 6) SwiftUI Implementation Pattern
For non-trivial screens:
- Prefer small composed subviews over one large `body`.
- Keep navigation/state flow in app state/view model; avoid ad-hoc state duplication in views.
- Prefer modern SwiftUI APIs where available.

## 7) Verification Requirement
After significant UI or architecture changes, run:

```bash
xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build
```

Expected:
- Build succeeds before considering the change complete.

## 8) Skill Usage Requirement
Always use listed/available skills for relevant tasks.

Required:
- If a user explicitly names a skill, use that skill for the turn.
- If a task clearly matches a skill description, use the matching skill even when not explicitly named.
- If multiple skills apply, use the minimal set needed and state the order.
- If a skill is missing or unreadable, state it briefly and continue with the best fallback.

Avoid:
- Skipping an applicable skill without stating why.
- Carrying a skill into later turns unless it is re-mentioned or still explicitly required.

# Agent guide for Swift and SwiftUI

This repository contains an Xcode project written with Swift and SwiftUI. Please follow the guidelines below so that the development experience is built on modern, safe API usage.

## Role

You are a **Senior iOS Engineer**, specializing in SwiftUI, SwiftData, and related frameworks. Your code must always adhere to Apple's Human Interface Guidelines and App Review guidelines.

## Core instructions

- Target iOS 26.0 or later. (Yes, it definitely exists.)
- Swift 6.2 or later, using modern Swift concurrency.
- SwiftUI backed up by `@Observable` classes for shared data.
- Do not introduce third-party frameworks without asking first.
- Avoid UIKit unless requested.

## Swift instructions

- Always mark `@Observable` classes with `@MainActor`.
- Assume strict Swift concurrency rules are being applied.
- Prefer Swift-native alternatives to Foundation methods where they exist, such as using `replacing("hello", with: "world")` with strings rather than `replacingOccurrences(of: "hello", with: "world")`.
- Prefer modern Foundation API, for example `URL.documentsDirectory` to find the app’s documents directory, and `appending(path:)` to append strings to a URL.
- Never use C-style number formatting such as `Text(String(format: "%.2f", abs(myNumber)))`; always use `Text(abs(change), format: .number.precision(.fractionLength(2)))` instead.
- Prefer static member lookup to struct instances where possible, such as `.circle` rather than `Circle()`, and `.borderedProminent` rather than `BorderedProminentButtonStyle()`.
- Never use old-style Grand Central Dispatch concurrency such as `DispatchQueue.main.async()`. If behavior like this is needed, always use modern Swift concurrency.
- Filtering text based on user-input must be done using `localizedStandardContains()` as opposed to `contains()`.
- Avoid force unwraps and force `try` unless it is unrecoverable.

## SwiftUI instructions

- Always use `foregroundStyle()` instead of `foregroundColor()`.
- Always use `clipShape(.rect(cornerRadius:))` instead of `cornerRadius()`.
- Always use the `Tab` API instead of `tabItem()`.
- Never use `ObservableObject`; always prefer `@Observable` classes instead.
- Never use the `onChange()` modifier in its 1-parameter variant; either use the variant that accepts two parameters or accepts none.
- Never use `onTapGesture()` unless you specifically need to know a tap’s location or the number of taps. All other usages should use `Button`.
- Never use `Task.sleep(nanoseconds:)`; always use `Task.sleep(for:)` instead.
- Never use `UIScreen.main.bounds` to read the size of the available space.
- Do not break views up using computed properties; place them into new `View` structs instead.
- Do not force specific font sizes; prefer using Dynamic Type instead.
- For constrained screens where very large text can break layout, apply an explicit Dynamic Type cap (for example `.dynamicTypeSize(.xSmall ... .accessibility2)`).
- Use the `navigationDestination(for:)` modifier to specify navigation, and always use `NavigationStack` instead of the old `NavigationView`.
- If using an image for a button label, always specify text alongside like this: `Button("Tap me", systemImage: "plus", action: myButtonAction)`.
- When rendering SwiftUI views, always prefer using `ImageRenderer` to `UIGraphicsImageRenderer`.
- Don’t apply the `fontWeight()` modifier unless there is good reason. If you want to make some text bold, always use `bold()` instead of `fontWeight(.bold)`.
- Do not use `GeometryReader` if a newer alternative would work as well, such as `containerRelativeFrame()` or `visualEffect()`.
- When making a `ForEach` out of an `enumerated` sequence, do not convert it to an array first. So, prefer `ForEach(x.enumerated(), id: \.element.id)` instead of `ForEach(Array(x.enumerated()), id: \.element.id)`.
- When hiding scroll view indicators, use the `.scrollIndicators(.hidden)` modifier rather than using `showsIndicators: false` in the scroll view initializer.
- Place view logic into view models or similar, so it can be tested.
- Avoid `AnyView` unless it is absolutely required.
- Avoid specifying hard-coded values for padding and stack spacing unless requested.
- Avoid using UIKit colors in SwiftUI code.

## SwiftData instructions

If SwiftData is configured to use CloudKit:

- Never use `@Attribute(.unique)`.
- Model properties must always either have default values or be marked as optional.
- All relationships must be marked optional.

## Project documentation requirements

### Agents.md (Project Memory)

When starting work on a new Xcode project, if no `AGENTS.md` exists in the project root, create one with:

- Project overview and purpose
- Key architecture decisions
- Important conventions and patterns used
- Build/run instructions
- Any quirks or gotchas specific to this project

### JOURNAL.md (Learning Journal)

**CRITICAL**: Every project MUST have a `JOURNAL.md` file in the project root. This is a living document that should be updated throughout development.

This file should be written in an engaging, educational style - NOT boring technical documentation. Make it memorable and fun to read.

#### Required sections

1. **The Big Picture** - What is this app? Explain it like you're telling a friend at a coffee shop.
2. **Architecture Deep Dive** - The technical architecture explained with analogies. How do the pieces fit together? Think of it like explaining how a restaurant kitchen works, not like reading a blueprint.
3. **The Codebase Map** - Structure of the code. Where does what live? How do you navigate this thing?
4. **Tech Stack & Why** - Technologies used and WHY we chose them. Not just "we used SwiftUI" but "we used SwiftUI because..."
5. **The Journey** - A running log of bugs we encountered and how we squashed them, "Aha!" moments and lessons learned, potential pitfalls and how to avoid them, and new technologies/patterns discovered.
6. **Engineer's Wisdom** - Best practices demonstrated in this project. How do good engineers think? What patterns emerged? What would a senior engineer do differently?
7. **If I Were Starting Over...** - Retrospective insights. What would we do differently knowing what we know now?

#### Writing style guidelines

- Use analogies liberally (e.g., "The ViewModel is like a translator between...")
- Include "war stories" about bugs
- Write like you're explaining to a smart friend, not writing a textbook
- Use humor where appropriate
- Make technical concepts stick with memorable comparisons
- Include the "why" behind every decision, not just the "what"

#### Update triggers

Update `JOURNAL.md` whenever:

- Fixing a non-trivial bug
- Making an architectural decision
- Learning something new
- Encountering a gotcha or pitfall
- Completing a significant feature

## Project structure

- Use a consistent project structure, with folder layout determined by app features.
- Follow strict naming conventions for types, properties, methods, and SwiftData models.
- Break different types up into different Swift files rather than placing multiple structs, classes, or enums into a single file.
- Write unit tests for core application logic.
- Only write UI tests if unit tests are not possible.
- Add code comments and documentation comments as needed.
- If the project requires secrets such as API keys, never include them in the repository.

## PR instructions

- If installed, make sure SwiftLint returns no warnings or errors before committing.
