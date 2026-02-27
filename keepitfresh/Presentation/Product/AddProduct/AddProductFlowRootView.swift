//
//  AddProductFlowRootView.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Root state-driven navigation surface for add-product flow.
//

import SwiftUI

struct AddProductFlowRootView: View {
    @State var viewModel: AddProductViewModel
    @State private var reviewViewModel: ProductReviewViewModel?

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .scanning:
                BarcodeScannerScreen(
                    onSubmitManualBarcode: viewModel.submitManualBarcode,
                    onSkipToCamera: viewModel.skipToCaptureImages
                )

            case .resolving(let barcode):
                progressScreen(
                    title: "Looking Up Barcode",
                    message: "Checking inventory and catalog for \(barcode.value)"
                )

            case .inventoryFound, .catalogFound:
                progressScreen(
                    title: "Preparing Product",
                    message: "Found product details. Building review form..."
                )

            case .barcodeNotFound(let context):
                notFoundScreen(context: context)

            case .captureImages(_, let plan):
                CaptureImagesScreen(
                    maxImages: plan.maximumImageCount,
                    onSubmit: viewModel.submitCapturedImages,
                    onBack: viewModel.retryLastBarcode
                )

            case .extracting:
                if let reviewViewModel {
                    ProductReviewView(
                        viewModel: reviewViewModel,
                        onAdd: { product in
                            let numberOfItems = max(1, reviewViewModel.numberOfItems)
                            viewModel.saveExtractedProduct(product, numberOfItems: numberOfItems)
                        }
                    )
                } else {
                    progressScreen(title: "Preparing", message: "Building review draft…")
                }

            case .manualEntry(let draft):
                reviewScreen(for: draft)
            case .reviewing(let draft, _):
                reviewScreen(for: draft)
            case .saving:
                progressScreen(title: "Saving", message: "Persisting product locally and syncing…")

            case .success(let savedItemId):
                successScreen(savedItemId: savedItemId)

            case .failure(let message):
                failureScreen(message: message)
            }
        }
        .task {
            syncReviewViewModel(for: viewModel.state)
            await viewModel.start()
        }
        .onChange(of: viewModel.state) { _, newState in
            syncReviewViewModel(for: newState)
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }

    private func reviewScreen(for draft: ProductDraft) -> some View {
        ReviewProductScreen(
            draft: Binding(
                get: { viewModel.draft ?? draft },
                set: { viewModel.draft = $0 }
            ),
            onSave: viewModel.saveDraft,
            onSaveAndAddAnother: viewModel.saveAndAddAnother,
            onBack: viewModel.retryLastBarcode
        )
    }

    private func progressScreen(title: String, message: String) -> some View {
        VStack(spacing: Theme.Spacing.s12) {
            ProgressView()
                .tint(Theme.Colors.accent)
            Text(title)
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            Text(message)
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(Theme.Spacing.s20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }

    private func notFoundScreen(context: AddProductNotFoundContext) -> some View {
        VStack(spacing: Theme.Spacing.s16) {
            Text("Product Not Found")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)

            Text(context.message)
                .font(Theme.Fonts.body(15, weight: .regular, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Button("Take Picture and Analyze", action: viewModel.skipToCaptureImages)
                .primaryButtonStyle(height: 48)

            Button("Enter Details Manually", action: viewModel.openManualDraft)
                .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))

            Button("Retry Barcode", action: viewModel.retryLastBarcode)
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(Theme.Spacing.s20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }

    private func failureScreen(message: String) -> some View {
        VStack(spacing: Theme.Spacing.s16) {
            Text("Something went wrong")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.danger)

            Text(message)
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)

            Button("Retry", action: viewModel.retryLastBarcode)
                .primaryButtonStyle(height: 46)

            Button("Enter Manually", action: viewModel.openManualDraft)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
        }
        .padding(Theme.Spacing.s20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }

    private func successScreen(savedItemId: String) -> some View {
        VStack(spacing: Theme.Spacing.s16) {
            Text("Saved")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)

            Text("Item ID: \(savedItemId)")
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)

            Button("Add Another", action: viewModel.startAnother)
                .primaryButtonStyle(height: 46)
        }
        .padding(Theme.Spacing.s20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }

    private func syncReviewViewModel(for state: AddProductState) {
        guard case let .extracting(images) = state else {
            reviewViewModel = nil
            return
        }

        let incomingIDs = images.map(\.id)
        let currentIDs = reviewViewModel?.capturedImages.map(\.id)
        if incomingIDs != currentIDs {
            reviewViewModel = ProductReviewViewModel(capturedImages: images)
        }
    }
}

#if DEBUG
#Preview {
    AddProductFlowRootView(viewModel: AddProductModuleAssembler().makeViewModel())
}
#endif
