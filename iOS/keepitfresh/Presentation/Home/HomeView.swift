//
//  HomeView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Renders inventory urgency buckets with actions, undo, and Add Product flow entry.
//

import SwiftUI
import InventoryModule
import CameraModule

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var inventoryViewModel = HomeViewModel()
    
    @State private var showBarcodeScanner: Bool = false
    @State private var showImageScanner: Bool = false

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                if inventoryViewModel.expiredCount > 0 {
                    HomeExpiredSummaryCardView(expiredCount: inventoryViewModel.expiredCount)
                }

                HomeInventoryStateView(
                    uiState: inventoryViewModel.uiState,
                    mutatingItemIDs: inventoryViewModel.mutatingItemIDs,
                    onSelect: { row in
                        appState.navigate(to: .inventoryItemDetail(row.item))
                    },
                    onDiscard: { row in
                        await performDiscard(for: row)
                    },
                    onFinished: { row in
                        await performFinish(for: row)
                    },
                    onAddNew: {  }
                )
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.top, Theme.Spacing.s16)
        }
        .safeAreaInset(edge: .bottom) {
            bottomActionArea
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            HomeAddProductButtonView(onTap: { showBarcodeScanner.toggle() })
                .padding(.trailing, 20)
        }
        .refreshable {
            await inventoryViewModel.loadInventory(householdId: appState.selectedHouse?.id)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: inventoryViewModel.expiredCount) { _, newCount in
            appState.homeExpiredBadgeCount = newCount
        }
        .fullScreenCover(isPresented: $showBarcodeScanner) {
            BarcodeScannerActionSheet(
                onCancel: { showBarcodeScanner.toggle() },
                onBarcodeDetected: { barcode in
                    startAddProductFlow(barcode: barcode.toBarcode)
                    showBarcodeScanner.toggle()
                },
                methodChanged: { method in
                    switch method {
                        case .imageScanner: showImageScanner.toggle()
                        default: break
                    }
                    
                    showBarcodeScanner.toggle()
                }
            )
        }
        .fullScreenCover(isPresented: $showImageScanner) {
            CameraScannerView(
                onCancel: { showImageScanner.toggle() },
                onComplete: { images in
                    startAddProductFlow(images: images.imagesCaptured)
                }
            )
        }
        .task(id: appState.selectedHouse?.id) {
            await inventoryViewModel.loadInventory(householdId: appState.selectedHouse?.id)
            appState.homeExpiredBadgeCount = inventoryViewModel.expiredCount
        }
    }

    @ViewBuilder
    private var bottomActionArea: some View {
        VStack(spacing: Theme.Spacing.s12) {
            if let undoBanner = inventoryViewModel.undoBanner {
                HomeUndoBannerView(
                    message: undoBanner.message,
                    onUndo: {
                        Task {
                            if await inventoryViewModel.undoLastAction(householdId: appState.selectedHouse?.id) {
                                generateHaptic(.success)
                            }
                        }
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(.horizontal, Theme.Spacing.s16)
        .padding(.top, Theme.Spacing.s8)
        .padding(.bottom, Theme.Spacing.s12)
        .frame(maxWidth: .infinity)
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

    private func startAddProductFlow(barcode: Barcode) {
        appState.navigate(to: .addProduct(.barcode(barcode)))
    }
    
    private func startAddProductFlow(images: [ImagesCaptured]) {
        appState.navigate(to: .addProduct(.imageCapture(images)))
    }

    private func generateHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

// MARK: - Navigation
extension HomeView {
    
}

#if DEBUG
#Preview {
    HomeView()
        .environment(AppState())
}
#endif
