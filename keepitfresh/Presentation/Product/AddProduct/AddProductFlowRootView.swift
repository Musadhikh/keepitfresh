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

    var body: some View {
        Group {
            switch viewModel.state {
            case .captureImages:
                VStack {
                    Text("Couldn't find any products in the images.")
                    CaptureImagesScreen(
                        onSubmit: viewModel.submitCapturedImages,
                        onBack: viewModel.retryLastBarcode
                    )
                }
            case .scanning:
                ProgressView("Scanning...")
            case .extracting(let images):
                ProductReviewView(
                    viewModel: ProductReviewViewModel(capturedImages: images),
                    onAdd: {}
                )

            case .reviewing:
                if let draftBinding = draftBinding {
                    ReviewProductScreen(
                        draft: draftBinding,
                        onSave: viewModel.saveDraft,
                        onSaveAndAddAnother: viewModel.saveAndAddAnother,
                        onBack: viewModel.retryLastBarcode
                    )
                } else {
                    progressScreen(title: "Preparing", message: "Loading draft…")
                }

            case .saving:
                progressScreen(title: "Saving", message: "Persisting product locally and syncing…")

            case .success(let savedItemId):
                successScreen(savedItemId: savedItemId)

            default:
                scannerScreenWithResolveSheet
            }
        }
        .task {
            await viewModel.start()
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }

    private var scannerScreenWithResolveSheet: some View {
        ZStack(alignment: .bottom) {
            BarcodeScannerScreen(
                onSubmitManualBarcode: viewModel.submitManualBarcode,
                onSkipToCamera: viewModel.skipToCaptureImages
            )

            ResolveBottomSheet(
                state: viewModel.state,
                onRetry: viewModel.retryLastBarcode,
                onManual: viewModel.openManualDraft,
                onContinueCatalog: viewModel.continueFromCatalog,
                onContinueCamera: viewModel.skipToCaptureImages,
                onQuickAddOne: viewModel.quickAddOne,
                onQuickAddBatch: viewModel.quickAddBatch,
                onEditDates: viewModel.editDates
            )
        }
    }

    private var draftBinding: Binding<ProductDraft>? {
        guard viewModel.draft != nil else { return nil }
        return Binding(
            get: { viewModel.draft ?? .makeManual() },
            set: { viewModel.draft = $0 }
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
}

#if DEBUG
#Preview {
    AddProductFlowRootView(viewModel: AddProductModuleAssembler().makeViewModel())
}
#endif
