# # 📱 GOOGLE STITCH PROMPT
# KeepItFresh — Add Product / Purchase / Inventory Flow
Platform: iOS 26+ Style: Apple HIG + Liquid Glass Modes: Light & Dark Use SF Symbols only Minimal, elegant, premium

# 🧠 Context
KeepItFresh is a household inventory app that tracks expiry dates.
Users can:
* Scan product labels
* Scan barcodes
* Search products
* Add manually
* Confirm purchase details (quantity, expiry, storage)

⠀Design must:
* Feel native to iOS 26
* Use glass materials
* Avoid clutter
* Be clean and highly usable
* Prioritize one primary action per screen

⠀
# SCREEN 1 — ADD ACTION SHEET
Presentation: Bottom sheet (medium + large detents)
Title: **Add** Subtitle: “Scan a label or add manually”
Top right:
* Close button (xmark)

⠀Top section: Household selector pill Icon: house.fill Text: “Home” Chevron down

# Action Cards (Glass Style, Large Tap Targets)
Each card:
* Rounded corners
* Glass background
* Leading SF Symbol
* Title
* Subtitle
* Chevron right

⠀1️⃣ Scan Label Icon: text.viewfinder Subtitle: “Detect name and expiry”
2️⃣ Scan Barcode Icon: barcode.viewfinder Subtitle: “Find product instantly”
3️⃣ Search Products Icon: magnifyingglass Subtitle: “Browse saved items”
4️⃣ Manual Add Icon: square.and.pencil Subtitle: “Enter details yourself”
5️⃣ Quick Add Icon: sparkles Subtitle: “Eggs, Milk, Tomato…”
Primary accent color used subtly on icons.

# SCREEN 2 — SCAN LABEL
Full screen camera layout.
Top: Title: “Scan Label” Instruction text: “Align label inside frame”
Center: Rounded rectangular scanning frame Dimmed outer area Animated corner indicators
Bottom: Primary button: “Capture” with camera Accent filled glass button
Secondary controls: Torch toggle (flashlight.on.fill) Auto-detect switch
Floating detection chips (glass capsules):
* calendar Use by: 01 Nov 2026
* tag Lipton Yellow Label
* barcode 8720608629091

⠀Chips show subtle confidence indicator.

# SCREEN 3 — EXTRACTION REVIEW
Presented as large sheet.
Title: “Review Details”
Section: Product Info (glass card)
* Product Name (editable field)
* Category picker
* Brand field

⠀Section: Dates (glass card) List rows:
* Expiry Date
* Manufactured Date Each row:
* Label
* Date picker
* Dropdown for kind

⠀Section: Barcode Editable text field
Primary button: “Continue”

# SCREEN 4 — PRODUCT SEARCH
Navigation style screen.
Top: Large search bar Placeholder: “Search products”
Below: Horizontal filter chips: Fresh • Frozen • Pantry • Household • All
Product list rows: Leading circular glass icon Product title Subtitle (category + brand) Chevron right
Selecting → Confirm Purchase

# SCREEN 5 — MANUAL ADD
Navigation style form.
Title: “Manual Add”
Sections:
Product Details (glass card)
* Product Name
* Category
* Brand

⠀Expiry (glass card)
* Date picker
* Quick chips: +3 days +7 days +30 days

⠀Storage (segmented control)
* snowflake Freezer
* refrigerator Fridge
* cabinet Pantry

⠀Quantity Stepper Unit segmented control: Count • Weight • Volume
Toggle: “Save as reusable product”
Primary button: “Add to Inventory”

# SCREEN 6 — CONFIRM PURCHASE (CORE SCREEN)
Navigation title: Product Name
Header: Large circular glass icon Product title Category subtitle
Sections (glass cards):

### Quantity
Stepper Unit segmented control

### Expiry
Primary expiry date field Expandable: “Add manufactured date”
Quick chips for common durations.

### Storage
Segmented control: Freezer • Fridge • Pantry
Optional location text field.

### Reminders
Toggle: “Remind me” Options: On expiry 1 day before 3 days before Custom

### Notes
Multiline text field

Bottom fixed primary button: “Add to Inventory”
Secondary: “Save Draft”
After success: Floating toast: “Added • Eggs (12) to Fridge”

# VISUAL RULES
* Use glass material backgrounds
* Rounded corners
* Soft shadow depth
* SF Symbols only
* Apple system typography
* Spacious layout
* Clear hierarchy
* Light & Dark versions required
* No heavy gradients
* No clutter

#kif/ios/brain