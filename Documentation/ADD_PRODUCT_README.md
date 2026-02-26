# Add Product Module

This module scaffolds the complete Add Product flow with clean layering:

- `AddProduct/Domain`: Models, contracts, and actor use case
- `AddProduct/Data`: In-memory repositories + optional Firestore stubs
- `AddProduct/Presentation`: ViewModel + state-driven SwiftUI screens
- `AddProduct/DI`: `AddProductModuleAssembler` composition root

## Flow

1. Scan barcode
2. Resolve in order: inventory local -> inventory remote -> catalog local -> catalog remote
3. If unresolved: capture images -> extraction -> review
4. Save local first, then remote best-effort; enqueue sync on remote failure

## Home FAB Wiring

Present `AddProductFlowRootView` from Home screen:

```swift
@State private var isAddProductPresented = false

Button {
    isAddProductPresented = true
} label: {
    Label("Add Product", systemImage: "plus")
}

.fullScreenCover(isPresented: $isAddProductPresented) {
    NavigationStack {
        AddProductModuleAssembler().makeRootView()
    }
}
```

The default assembler uses in-memory repositories, so it works without Firestore configuration.
