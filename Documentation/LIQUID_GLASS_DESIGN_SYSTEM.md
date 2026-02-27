# Keep It Fresh Liquid Glass Design System

## Purpose
This document captures the mobile design system defined in Stitch for:
- `Design System - Liquid Glass Edition` (dark mode reference)
- `Design System - Liquid Glass Light` and `Design System - Liquid Glass Light (Matched)` (light mode references)

It is intended as the implementation contract for SwiftUI work in this repository.

## Design Direction
- Visual style: clean mobile surfaces with soft translucency and mint-accent highlights.
- Brand tone: fresh, calm, health-oriented, high readability.
- Material language: rounded cards and pills, subtle depth, low-contrast borders, and soft glow accents.

## Color Tokens
Use `Theme.Colors.*` in production views. The table below reflects the Stitch palette and current app token mapping.

| Semantic Token | Light Mode | Dark Mode | Notes |
| --- | --- | --- | --- |
| Primary Accent | `#3CB371` | `#52C884` | Main action and emphasis |
| Accent Soft | `#E8F7EE` | `#1E382A` | Tinted glass fills and chips |
| Background | `#F6F8F7` | `#111412` | App background |
| Surface | `#FFFFFF` | `#1A1F1C` | Cards and elevated containers |
| Surface Alt | `#EFF5F1` | `#242B27` | Secondary containers |
| Border | `#D7E2DC` | `#34423B` | Outlines and separators |
| Text Primary | `#17201B` | `#F1F5F2` | Headlines and primary copy |
| Text Secondary | `#5E6E65` | `#A6B6AD` | Supporting copy |
| Success | `#3CB371` | `#52C884` | Positive states |
| Warning | `#EFB849` | `#F2C86A` | Warning states |
| Danger | `#DF5A57` | `#E57A76` | Critical/urgent states |

Stitch-specific notes:
- Dark board explicitly defines `#52C884` and `RGBA(82, 200, 132, 0.15)` for accent soft overlays.
- Dark board surface token is shown as `#1A1F1C`.
- Light board shows palette labels `Primary`, `Deep`, `Mint`, `Honeydew`, `Pure`; treat these as tonal support around the semantic tokens above.

## Typography Scale
Typography in Stitch maps cleanly to current theme tokens and should remain Dynamic Type friendly.

| Stitch Scale | Size / Weight (Stitch) | App Token |
| --- | --- | --- |
| Display / Title Large | 28pt / semibold-bold | `Theme.Fonts.titleLarge` |
| Heading / Title | 22pt / semibold | `Theme.Fonts.title` |
| Body Medium | 16pt / medium | `Theme.Fonts.bodyMedium` |
| Body Regular | 16pt / regular | `Theme.Fonts.bodyRegular` |
| Caption | 12pt / medium | `Theme.Fonts.caption` |

Guidelines:
- Keep sentence-case for interface copy (matches Stitch boards).
- Use `bold()` only when needed for hierarchy within a shared text style.
- Preserve contrast in both modes by pairing text with semantic surface tokens.

## Shape, Spacing, and Material
### Radius
- Card radius: `Theme.Radius.r20` to `Theme.Radius.r24`
- Field/button radius: `Theme.Radius.pill` for primary liquid controls
- Small icon chips: `Theme.Radius.r12` to `Theme.Radius.r16`

### Spacing
- Micro: `Theme.Spacing.s4`, `Theme.Spacing.s8`
- Component internal: `Theme.Spacing.s12`, `Theme.Spacing.s16`
- Section rhythm: `Theme.Spacing.s20`, `Theme.Spacing.s24`, `Theme.Spacing.s32`

### Liquid Glass Treatment
- Use low-contrast tinted surfaces (`accentSoft`, `surfaceAlt`) over base background.
- Keep borders subtle (`Theme.Colors.border` at full or reduced opacity).
- Prefer gentle shadow/depth over high-contrast drop shadows.

## Core Component Specs
### Buttons
- Primary (glass filled): accent-filled pill with high-contrast foreground text/icon.
- Secondary: soft filled pill (`accentSoft`/`surfaceAlt`) with accent text.
- Outline: transparent or surface fill with border token.
- Ghost: no heavy container; text-led action.

### Inputs and Toggles
- Text field: rounded container, low-contrast fill, clear placeholder hierarchy.
- Date/input rows: maintain minimum hit size and consistent vertical rhythm.
- Notification toggle: pill switch with accent for enabled state.

### Status + Cards
- Expiring card:
  - leading product thumbnail/icon area
  - product name + expiry metadata
  - urgency chip using `danger` (urgent) or `warning` (soon)
- Keep metadata in `TextSecondary`, never equal visual weight to title.

### Household Selector
- Elevated surface with leading context label and trailing affordance.
- Selected state should be obvious in both modes without relying on color alone.

### Icon Chips / Material Icons
- Circular or rounded-square icon containers on soft surfaces.
- Use semantic icon color contrast by mode (accent in light, mint/white mix in dark).
- In code, use `Theme.Icon.*` and `Image(icon:)`; avoid hardcoded symbol strings.

### Bottom Navigation
- Rounded elevated bar, subtle border, and center-emphasis action where required.
- Active tab uses accent; inactive tabs use secondary text tone.

## Dark and Light Mode Behavior
### Dark Mode
- Background and surface separation must remain visible (`#111412` vs `#1A1F1C`).
- Accent glow should be restrained; avoid neon oversaturation on large areas.
- Text hierarchy:
  - primary text: bright neutral (`textPrimary`)
  - secondary text: muted neutral (`textSecondary`)

### Light Mode
- Preserve soft contrast; avoid pure black text blocks on tinted cards.
- Keep accent-heavy elements limited to actionable surfaces and status highlights.
- Ensure white/pure surfaces do not visually merge with app background.

## Accessibility and HIG Constraints
- Minimum touch targets: 44x44pt.
- Dynamic Type support is required for all text elements.
- Do not communicate urgency only by color; include text labels (`URGENT`, `2 days left`).
- Maintain mode-safe contrast for text and controls on all semantic surfaces.

## SwiftUI Implementation Contract
Use these tokens and patterns in app views:

```swift
RoundedRectangle(cornerRadius: Theme.Radius.r20, style: .continuous)
    .fill(Theme.Colors.surface)
    .overlay {
        RoundedRectangle(cornerRadius: Theme.Radius.r20, style: .continuous)
            .stroke(Theme.Colors.border, lineWidth: 1)
    }

Button("Scan Barcode", systemImage: Theme.Icon.productBarcode.systemName) {
    // action
}
.font(Theme.Fonts.bodyMedium)
.foregroundStyle(Theme.Colors.textPrimary)
```

## Source Reference
- Stitch project: `projects/5941626074478125770`
- Primary reference board: `Design System - Liquid Glass Edition`
- Companion light references:
  - `Design System - Liquid Glass Light`
  - `Design System - Liquid Glass Light (Matched)`
