# Homepage

Home page UI design
Skills to use: swiftui-expert-skill, swiftui-navigation-skill, swift-architecture

Stitch UI links:
| [Design with AI](https://stitch.withgoogle.com/projects/5941626074478125770?node-id=f0aa15a97dad44aba6efae1930a23522)
| [Design with AI](https://stitch.withgoogle.com/projects/5941626074478125770?node-id=ef9ef42c493a44cf999bebb366406cb5)
| [Design with AI](https://stitch.withgoogle.com/projects/5941626074478125770?node-id=a213f4b29b4540ee96f8c8ef3e9050a5)
| https://stitch.withgoogle.com/projects/5941626074478125770?node-id=a39e6cd85d4643b1a7a376ef9287a020
[Design with AI](https://stitch.withgoogle.com/projects/5941626074478125770?node-id=74088680dc4c4ad084df7c25507db747)

The links above are for references. The UIs might be different in the links but use what make sense. strictyly follow the design system.


Home page (HomeView) will be the place where the app will list all the immediate expiring items.
Home page should show a message card with how many items are already expired and need actions from user. this message has no actions but just a message to inform user.

Home page should list following in the order of the expiry date
- Expired items
- Items expiring soon (3 days)
- Items expiring in 7 days (excluding what is already listed)

1. Each item should have 3 options. (Discard, Finished, Add New)
2. For items, use Relevant SF Symbols instead of custom image
3. For each item, show item title, category, expiry/Expired date
4. Reduced shadow and Liquid glass effect on icons and buttons
5. Strictly follow the design system
6. Follow the skills to have a buttery smooth UI
7. User can tap on an item and go to details screen. (Simple UI for now)


# Expired Summary Message Card
If there are expired items:
"⚠️ You have 5 expired items that need attention."
No action. Just information.
### UI Style
* Glass background
* Subtle red tint
* Rounded 20–24 corner radius
* No shadow or very soft shadow
* Symbol: exclamationmark.triangle.fill

# Item Row Design
Each item row should contain:
| **Element** | **Description** |
|:-:|:-:|
| Leading icon | Category-based SF Symbol |
| Title | Bold |
| Category | Secondary |
| Expiry label | Red if expired |
| Action buttons | 3 small icon buttons |

### Liquid Glass Treatment
* Icon container → .background(.ultraThinMaterial)
* Buttons → .glassEffect() style modifier (custom)
* Reduced shadow (0–2 blur max)

# SF Symbol Suggestions
### Expired
* exclamationmark.triangle.fill
* calendar.badge.exclamationmark

⠀Discard
* trash.fill

⠀Finished
* checkmark.circle.fill

⠀Add New
* plus.circle.fill

### Categories
| **Category** | **Symbol** |
|:-:|:-:|
| Dairy | carton.fill |
| Fruits | apple.logo or leaf.fill |
| Meat | fork.knife |
| Household | house.fill |
| Medicine | cross.case.fill |

# Empty State
If no expiring items:
Show a calming card:
"You're all good 🎉 No items expiring soon."
Symbol: checkmark.seal.fill

# Pull To Refresh
You are syncing with Firestore.

# Undo Support
If user taps:
* Discard
* Finished

⠀You MUST show:
* Snackbar / overlay toast
* With undo

⠀This prevents accidental deletion.

# Time Intelligence Label
Instead of static text:
Use dynamic formatting:
* "Expired 2 days ago"
* "Expires Today"
* "Expires in 3 days"

⠀Use RelativeDateTimeFormatter.

# Soft Color Coding (Very Subtle)
Colours must match the design system. Below is for reference only
| **State** | **Tint** |
|:-:|:-:|
| Expired | .red.opacity(0.15) |
| 3 days | .orange.opacity(0.12) |
| 7 days | .yellow.opacity(0.08) |
Do NOT use solid backgrounds. Only subtle tint overlays.

# Haptic Feedback
* Discard → .notification(.warning)
* Finished → .success

⠀Small but premium feel.

# Badge Count In Tab
Your tab bar icon should show badge count for expired items.

## Sorting Stability
Important for smooth UI:
Sort logic in ViewModel:

```swift
expired.sorted(by: expiryDate)
expiring3Days.sorted(by: expiryDate)
expiring7Days.sorted(by: expiryDate)
```

Never sort inside View.

# Architecture (Clean SwiftUI)
Given your Clean Architecture preference:
### HomeView
Pure View.
### HomeViewModel
* Fetch inventory
* Group by expiry buckets
* Provide UI-ready models

⠀State based UI

# Buttery Smoothness Notes
Since you care about performance:
### 1\. Use LazyVStack
Never VStack.
### 2\. Avoid heavy shadows
Glass already gives depth.
### 3\. Use@Observable ViewModel (iOS 26)
Not @StateObject unless necessary.
### 4\. UseEquatableView if needed
For rows to prevent unnecessary re-render.
### 5\. Animations
Use:
```swift
.withAnimation(.snappy)
```
Not default easeInOut.

* Use dynamic type friendly layout
* Respect accessibility contrast
* Add swipe actions (alternative to buttons)
* Add subtle section transitions
* Prepare for future filter toggle (All / Expired / Soon)


#kif/ios/brain