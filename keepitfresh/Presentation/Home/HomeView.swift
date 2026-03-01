//
//  HomeView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Renders inventory urgency buckets with actions, undo, and add-item scan entry.
//

import SwiftUI
import CameraModule
import BarcodeScannerModule
import InventoryModule
import UIKit

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var inventoryViewModel = HomeViewModel()
    @State private var isCameraPresented = false
    @State private var isBarcodeScannerPresented = false
    @State private var pendingAddProductBarcode: ScannedBarcode?
    @State private var capturedImages: [CameraCapturedImage] = []
    @State private var latestScannedBarcode: ScannedBarcode?
    @State private var selectedDetailItem: InventoryModuleTypes.InventoryItem?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                    if inventoryViewModel.expiredCount > 0 {
                        HomeExpiredSummaryCardView(
                            expiredCount: inventoryViewModel.expiredCount
                        )
                    }
                    HomeInventoryStateView(
                        uiState: inventoryViewModel.uiState,
                        mutatingItemIDs: inventoryViewModel.mutatingItemIDs,
                        onSelect: { row in
                            selectedDetailItem = row.item
                        },
                        onDiscard: { row in
                            await performDiscard(for: row)
                        },
                        onFinished: { row in
                            await performFinish(for: row)
                        },
                        onAddNew: {
                            startAddProductWithScan()
                        }
                    )
                }
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.top, Theme.Spacing.s16)
                .padding(.bottom, 96)
            }
            
            HomeAddProductButtonView(
                onTap: startAddProductWithScan
            )
            
            if let undoBanner = inventoryViewModel.undoBanner {
                HomeUndoBannerView(
                    message: undoBanner.message,
                    onUndo: {
                        Task {
                            let didUndo = await inventoryViewModel.undoLastAction(householdId: appState.selectedHouse?.id)
                            if didUndo {
                                generateHaptic(.success)
                            }
                        }
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.bottom, 84)
            }
        }
        .refreshable {
            await inventoryViewModel.loadInventory(householdId: appState.selectedHouse?.id)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(item: $selectedDetailItem) { item in
            InventoryItemDetailView(item: item)
        }
        .fullScreenCover(isPresented: $isCameraPresented, content: cameraScannerSheet)
        .fullScreenCover(isPresented: $isBarcodeScannerPresented, content: barcodeScannerSheet)
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
        .onChange(of: inventoryViewModel.expiredCount) { _, newCount in
            appState.homeExpiredBadgeCount = newCount
        }
        .task(id: appState.selectedHouse?.id) {
            await inventoryViewModel.loadInventory(householdId: appState.selectedHouse?.id)
            appState.homeExpiredBadgeCount = inventoryViewModel.expiredCount
        }
    }

    private func cameraScannerSheet() -> some View {
        CameraScannerView(
            onCancel: { isCameraPresented = false },
            onComplete: { result in
                if result.isEmpty { return }
                capturedImages = result
                isCameraPresented = false
            }
        )
    }

    private func barcodeScannerSheet() -> some View {
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

    private func performDiscard(for row: HomeViewModel.InventoryRowModel) async {
        let didDiscard = await inventoryViewModel.discard(row, householdId: appState.selectedHouse?.id)
        if didDiscard {
            generateHaptic(.warning)
        }
    }

    private func performFinish(for row: HomeViewModel.InventoryRowModel) async {
        let didFinish = await inventoryViewModel.finish(row, householdId: appState.selectedHouse?.id)
        if didFinish {
            generateHaptic(.success)
        }
    }

    private func startAddProductWithScan() {
        pendingAddProductBarcode = nil
        isBarcodeScannerPresented = true
    }

    private func generateHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

#if DEBUG
#Preview {
    HomeView()
        .environment(AppState())
}
#endif
