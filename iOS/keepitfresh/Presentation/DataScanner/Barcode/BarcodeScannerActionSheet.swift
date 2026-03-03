//
//
//  BarcodeScannerActionSheet.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: BarcodeScannerActionSheet
//
    

import SwiftUI
import BarcodeScannerModule

extension BarcodeScannerConfiguration {
    static var continuous: BarcodeScannerConfiguration {
        BarcodeScannerConfiguration(
            mode: .continuous,
            quality: .balanced,
            symbologies: [.ean13, .ean8, .upce, .code128],
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true,
            isHapticsEnabled: true,
            continuousDebounceInterval: 0.1,
            duplicateFilterInterval: 0.7
        )
    }
}

enum AddProductMethod {
    case barcodeScanner
    case imageScanner
    case search
    case manual
    case quickAdd
}

struct BarcodeScannerActionSheet: View {
    var onCancel: () -> Void
    var onBarcodeDetected: @MainActor (ScannedBarcode) -> Void
    var methodChanged: @MainActor (AddProductMethod) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            BarcodeScannerView(
                configuration: .continuous,
                onCancel: onCancel,
                onBarcodeDetected: onBarcodeDetected
            )

            HStack(spacing: 20) {
                RoundedVerticalButton(
                    title: "Scan Label",
                    icon: .textViewfinder,
                    accessibilityLabel: "Scan Label. Detect Product details",
                    action: { methodChanged(.imageScanner) }
                )
                
                RoundedVerticalButton(
                    title: "Search",
                    icon: .magnifyingGlass,
                    accessibilityLabel: "Search Products. Brows saved items",
                    action: { methodChanged(.search) }
                )
                
                RoundedVerticalButton(
                    title: "Add Manually",
                    icon: .squareAndPencil,
                    accessibilityLabel: "Add Manually. Enter details yourself",
                    action: { methodChanged(.manual) }
                )
                
                RoundedVerticalButton(
                    title: "Quick Add",
                    icon: .sparkles,
                    accessibilityLabel: "Quick Add. Eggs, Milk, etc.",
                    action: { methodChanged(.quickAdd) }
                )
            }
        }
    }
}

#if DEBUG
#Preview {
    BarcodeScannerActionSheet(
        onCancel: {},
        onBarcodeDetected: { _ in },
        methodChanged: { _ in }
    )
}
#endif
