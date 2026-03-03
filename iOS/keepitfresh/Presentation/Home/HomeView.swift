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
    @State var viewModel: HomeViewModel
    
    @State private var showBarcodeScanner: Bool = false
    @State private var showImageScanner: Bool = false

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                if viewModel.expiredCount > 0 {
                    HomeExpiredSummaryCardView(expiredCount: viewModel.expiredCount)
                }

                HomeInventoryStateView(
                    uiState: viewModel.uiState,
                    mutatingItemIDs: viewModel.mutatingItemIDs,
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
            HomeAddProductButtonView(
                onTap: { viewModel.navigateToProduct() }
            )
            .padding(.trailing, 20)
        }
        .refreshable {
            await viewModel.loadInventory(householdId: appState.selectedHouse?.id)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: viewModel.expiredCount) { _, newCount in
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
            await viewModel.loadInventory(householdId: appState.selectedHouse?.id)
            appState.homeExpiredBadgeCount = viewModel.expiredCount
        }
    }

    @ViewBuilder
    private var bottomActionArea: some View {
        VStack(spacing: Theme.Spacing.s12) {
            if let undoBanner = viewModel.undoBanner {
                HomeUndoBannerView(
                    message: undoBanner.message,
                    onUndo: {
                        Task {
                            if await viewModel.undoLastAction(householdId: appState.selectedHouse?.id) {
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
        let didDiscard = await viewModel.discard(row, householdId: appState.selectedHouse?.id)
        if didDiscard {
            generateHaptic(.warning)
        }
    }

    private func performFinish(for row: HomeViewModel.InventoryRowModel) async {
        let didFinish = await viewModel.finish(row, householdId: appState.selectedHouse?.id)
        if didFinish {
            generateHaptic(.success)
        }
    }

    private func startAddProductFlow(barcode: Barcode) {
    }
    
    private func startAddProductFlow(images: [ImagesCaptured]) {
    }

    private func generateHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}


#if DEBUG
#Preview {
    HomeView(viewModel: HomeViewModel(
        onNext: { _ in }
    ))
        .environment(AppState())
}
#endif
