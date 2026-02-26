//
//  HomeView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Displays home actions and starts add-product flow by scanning real barcodes from Home.
//

import SwiftUI
import CameraModule
import BarcodeScannerModule

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var isCameraPresented = false
    @State private var isBarcodeScannerPresented = false
    @State private var pendingAddProductBarcode: ScannedBarcode?
    @State private var capturedImages: [CameraCapturedImage] = []
    @State private var latestScannedBarcode: ScannedBarcode?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section("Quick Actions") {
                    Button {
                        startAddProductWithScan()
                    } label: {
                        Label("Add Product", systemImage: Theme.Icon.houseCreate.systemName)
                    }

                    Button {
                        startAddProductWithScan()
                    } label: {
                        Label("Scan Barcode", systemImage: Theme.Icon.productBarcode.systemName)
                    }
                    
                    Button {
                        isCameraPresented = true
                    } label: {
                        Label("Scan Images", systemImage: Theme.Icon.cameraScanner.systemName)
                    }

                    Button {
                        appState.navigate(to: .appInfo)
                    } label: {
                        Label("App Info", systemImage: Theme.Icon.appInfo.systemName)
                    }
                    
                    Button {
                        appState.setNavigation(tab: .profile, routes: [.profileDetails])
                    } label: {
                        Label("Open Profile Details", systemImage: Theme.Icon.profileDetails.systemName)
                    }
                    
                    Button {
                        appState.navigate(to: .householdSelection)
                    } label: {
                        Label("Select Household", systemImage: Theme.Icon.householdSelection.systemName)
                    }
                }

                if let latestScannedBarcode {
                    Section("Latest Barcode") {
                        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                            Text(latestScannedBarcode.payload)
                                .font(Theme.Fonts.body(17, weight: .semibold, relativeTo: .headline))
                                .foregroundStyle(Theme.Colors.textPrimary)

                            Text(latestScannedBarcode.symbology.uppercased())
                                .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .caption))
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                        .padding(.vertical, Theme.Spacing.s4)
                    }
                }
                
                Section("Deep Link Examples") {
                    Text("keepitfresh://profile")
                    Text("keepitfresh://profile/details")
                    Text("keepitfresh://app-info")
                    Text("keepitfresh://households/select")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
            .navigationTitle("Home")
            
            Button {
                startAddProductWithScan()
            } label: {
                Label {
                    Text("Add Product")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                } icon: {
                    Image(icon: .houseCreate)
                        
                }
            }
            .foregroundStyle(Theme.Colors.surface)
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.accent)
            .clipShape(.rect(cornerRadius: Theme.Radius.pill))
            .shadow(color: Theme.Colors.primary30, radius: Theme.Spacing.s8, y: Theme.Spacing.s4)
            .padding(.trailing, Theme.Spacing.s20)
            .padding(.bottom, Theme.Spacing.s20)
        }
        .fullScreenCover(isPresented: $isCameraPresented) {
            CameraScannerView(
                onCancel: { isCameraPresented = false },
                onComplete: { result in
                    if result.isEmpty { return }
                    capturedImages = result
                    isCameraPresented = false
                }
            )
        }
        .fullScreenCover(isPresented: $isBarcodeScannerPresented) {
            BarcodeScannerView(
                configuration: BarcodeScannerConfiguration(
                    mode: .continuous,
                    quality: .fast,
                    symbologies: [.ean13, .ean8, .upce, .code128],
                    isHighFrameRateTrackingEnabled: true,
                    isPinchToZoomEnabled: true,
                    isGuidanceEnabled: false,
                    isHighlightingEnabled: false,
                    isHapticsEnabled: true,
                    continuousDebounceInterval: 0.08,
                    duplicateFilterInterval: 0.75
                ),
                onCancel: { isBarcodeScannerPresented = false },
                onBarcodeDetected: { barcode in
                    guard pendingAddProductBarcode == nil else {
                        return
                    }
                    latestScannedBarcode = barcode
                    pendingAddProductBarcode = barcode
                    isBarcodeScannerPresented = false
                }
            )
        }
        .onChange(of: isBarcodeScannerPresented) { oldValue, newValue in
            guard oldValue == true, newValue == false, let barcode = pendingAddProductBarcode else { return }
            pendingAddProductBarcode = nil
            appState.navigate(
                to: .addProduct(
                    barcodePayload: barcode.payload,
                    symbology: barcode.symbology
                )
            )
        }
    }

    private func startAddProductWithScan() {
        pendingAddProductBarcode = nil
        isBarcodeScannerPresented = true
    }
}

#if DEBUG
#Preview {
    HomeView()
        .environment(AppState())
}
#endif
