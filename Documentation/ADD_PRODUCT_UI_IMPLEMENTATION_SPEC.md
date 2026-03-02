# Add Product UI Implementation Spec

Status: Draft for implementation handoff  
Last updated: 2026-03-02

## Purpose
This document defines the UI implementation contract for the Add Product flow in KeepItFresh, based on the Stitch prompt and generated screens. It is intended to be the single UI reference when we start coding the flow.

## Source References
- Prompt: `Documentation/UIPrompts/AddProductUIPrompt_for_Stitch.md`
- Stitch project: `projects/5941626074478125770` (Keep It Fresh)
- Generated Screens:
  - S1 `KIF Add Flow - S1 Action Sheet` (`dbd7e8053fe8450dbe9d294a69a91b81`)
  - S1 alt `Add Item Action Sheet` (`a70ad07ab7fc40fdbb45b290fde6bf9a`)
  - S2 `KIF Add Flow - S2 Scan Label` (`cc0afaaebd7845d197d3261015e9784e`)
  - S3 `KIF Add Flow - S3 Extraction Review` (`b07ad39701cf4d328b2162939b6a15d2`)
  - S4 `KIF Add Flow - S4 Product Search` (`faac746cd6774a29bc68e2cc84fe4e28`)
  - S5 `KIF Add Flow - S5 Manual Add` (`67dfc3225edf45caab317bbe41ff6c1f`)
  - S6 `KIF Add Flow - S6 Confirm Purchase` (`34b9fa916e864532b16c07d255d587a3`)
- Design system references:
  - `Documentation/LIQUID_GLASS_DESIGN_SYSTEM.md`
  - `iOS/keepitfresh/App/Theme.swift`

## Flow Overview
1. Add Action Sheet
2. Scan Label
3. Extraction Review
4. Product Search
5. Manual Add
6. Confirm Purchase

Primary intent: one clear next action per screen, native iOS behavior, minimal visual noise.

## UI Rules (Implementation Constraints)
- Use theme tokens only (`Theme.Colors`, `Theme.Fonts`, `Theme.Spacing`, `Theme.Radius`).
- Use `Theme.Icon` + `Image(icon:)` for symbols.
- Support light/dark with the same component hierarchy.
- Favor composable screen-local components.
- Avoid long conditional chains in View; use typed `UIState` in ViewModel.
- Keep navigation destinations attached outside lazy containers.

## Screen-by-Screen Spec

### S1 — Add Action Sheet
Presentation:
- Bottom sheet with medium/large detent behavior.

Structure:
- Header:
  - Title: `Add`
  - Subtitle: `Scan a label or add manually`
  - Top-right close button (`xmark`)
- Household selector pill:
  - Icon: `house.fill`
  - Label: `Home`
  - Trailing: `chevron.down`
- Action cards (5):
  1. `text.viewfinder` — Scan Label — Detect name and expiry
  2. `barcode.viewfinder` — Scan Barcode — Find product instantly
  3. `magnifyingglass` — Search Products — Browse saved items
  4. `square.and.pencil` — Manual Add — Enter details yourself
  5. `sparkles` — Quick Add — Eggs, Milk, Tomato…

Interactions:
- Tap action row: navigate to corresponding flow route.
- Tap close: dismiss sheet.
- Tap household pill: household picker menu/sheet.

State:
- Loading household name state supported.
- Disabled actions if prerequisite permission/state missing.

Accessibility:
- Row accessibility labels include title + subtitle.
- Close button has explicit `Close` label.

### S2 — Scan Label
Presentation:
- Full-screen camera capture layout.

Structure:
- Top:
  - Title: `Scan Label`
  - Instruction: `Align label inside frame`
- Center:
  - Rounded scan frame with dimmed outside region.
  - Corner indicators; optional scanning animation.
- Bottom controls:
  - Primary capture button (`camera` icon + `Capture`).
  - Torch toggle (`flashlight.on.fill`).
  - Auto-detect switch.
- Floating detection chips:
  - Date chip (`calendar`)
  - Name chip (`tag`)
  - Barcode chip (`barcode`)

Interactions:
- Capture triggers extraction pipeline.
- Torch toggle updates camera session config.
- Auto-detect controls capture automation.
- Chip tap opens review/edit affordance if available.

State:
- Camera permission denied state with recovery action.
- Scanning active, paused, processing states.

### S3 — Extraction Review
Presentation:
- Large sheet.

Structure:
- Title: `Review Details`
- Product Info card:
  - Product Name (editable)
  - Category picker
  - Brand field
- Dates card:
  - Expiry Date row (picker + kind selector)
  - Manufactured Date row (picker + kind selector)
- Barcode card/row:
  - Editable barcode text field
- Primary button: `Continue`

Interactions:
- Continue validates required fields and routes to confirm purchase.
- Invalid fields show inline errors.

State:
- Pre-filled extracted values with confidence metadata available for UI hints.

### S4 — Product Search
Presentation:
- Standard navigation screen.

Structure:
- Search bar: `Search products`
- Horizontal filter chips:
  - Fresh, Frozen, Pantry, Household, All
- Product list rows:
  - Leading circular icon
  - Title
  - Subtitle (category + brand)
  - Trailing chevron

Interactions:
- Search text updates result list.
- Filter chip modifies current query scope.
- Select row routes to Confirm Purchase prefilled with catalog product.

State:
- Loading, empty results, error/retry states.
- Recent searches optional (if available in app state).

### S5 — Manual Add
Presentation:
- Navigation form screen.

Structure:
- Title: `Manual Add`
- Product Details card:
  - Product Name
  - Category
  - Brand
- Expiry card:
  - Date picker
  - Quick chips: +3 days, +7 days, +30 days
- Storage segmented control:
  - Freezer (`snowflake`), Fridge (`refrigerator`), Pantry (`cabinet`)
- Quantity:
  - Stepper
  - Unit segmented control: Count, Weight, Volume
- Toggle:
  - `Save as reusable product`
- Primary button:
  - `Add to Inventory`

Interactions:
- Quick chips set expiry relative to local date.
- Add validates required fields and submits.

State:
- Form validation state + submit in-progress state.

### S6 — Confirm Purchase (Core)
Presentation:
- Navigation screen with bottom action area.

Structure:
- Nav title: product name
- Header:
  - Large circular icon
  - Product title
  - Category subtitle
- Cards:
  - Quantity: stepper + unit segmented control
  - Expiry: primary date + optional manufactured date + quick chips
  - Storage: segmented + optional location text
  - Reminders: toggle + options (on expiry, 1 day, 3 days, custom)
  - Notes: multiline field
- Bottom actions:
  - Primary: `Add to Inventory`
  - Secondary: `Save Draft`
- Success feedback:
  - Toast `Added • <Product> (<qty>) to <Location>`

Interactions:
- Add to Inventory writes through use case; shows success toast.
- Save Draft persists draft without final inventory add.

State:
- Saving, success, failure/retry.

## Navigation Contract
- `S1 -> S2` Scan Label
- `S1 -> Barcode Scanner` (existing route)
- `S1 -> S4` Search Products
- `S1 -> S5` Manual Add
- `S1 -> Quick Add Route` (existing or new lightweight picker)
- `S2 -> S3` on capture/extract
- `S3 -> S6` continue
- `S4 -> S6` with selected product prefill
- `S5 -> S6` or direct save based on flow choice

## Data Binding Contract (UI Inputs/Outputs)
Inputs expected by these screens:
- Household display name + household id
- Product candidates/search results
- Extracted field values + confidence
- Date options and selected date kinds
- Location options (if configured)

Outputs emitted by UI:
- Add action selected
- Scan capture request + torch/auto-detect settings
- Field edits (title/category/brand/barcode/date/storage/quantity/unit/notes)
- Final commands: add inventory, save draft, dismiss

## Implementation Notes for Later
- Keep this flow in dedicated presentation folders per screen.
- Use view-name-aligned view model naming.
- Shared components should move to `Presentation/CustomViewComponents` only when used by 2+ screens.
- Implement states as enums in view models (`idle/loading/content/error/saving/success`).

## Open Items (to finalize before coding)
- Household picker source and switching behavior in S1.
- Quick Add route definition and suggested presets list.
- Whether S5 saves directly or always routes through S6.
- Reminder custom scheduling UI shape in S6.
