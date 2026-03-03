//
//  AddProductFlowRootView.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Root state-driven S1-S6 Add Product flow composed with modular SwiftUI screens.
//

import SwiftUI
import CameraModule
import BarcodeScannerModule

struct AddProductFlowRootView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) var appState
    
    @State var viewModel: AddProductFlowRootViewModel
    @State private var isTorchEnabled = false
    @State private var isAutoDetectEnabled = true

    var body: some View {
        AddProductActionSheetView(
            householdName: "Home",
            onClose: { dismiss() },
            onScanLabel: viewModel.openScanLabel,
            onScanBarcode: viewModel.openScanBarcode,
            onSearchProducts: viewModel.openProductSearch,
            onManualAdd: viewModel.openManualAdd,
            onQuickAdd: viewModel.quickAddPreset
        )
        .fullScreenCover(isPresented: $viewModel.isBarcodeScannerPresented) {
            BarcodeScannerActionSheet(
                onCancel: { viewModel.isBarcodeScannerPresented = false },
                onBarcodeDetected: { scanned in
                    viewModel.isBarcodeScannerPresented = false
                    let barcode = Barcode(value: scanned.payload, symbology: .init(value: scanned.symbology))
                    viewModel.onDetectedBarcode(barcode)
                },
                methodChanged: viewModel.onMethodChange(to:)
            )
        }
        .fullScreenCover(isPresented: $viewModel.isImageCapturePresented) {
            cameraScannerSheet
        }
        .alert("Saved", isPresented: successAlertBinding) {
            Button("Done") {
                dismiss()
            }
            Button("Add Another") {
                viewModel.startAnother()
            }
        } message: {
            Text("Product saved to inventory.")
        }
        .alert("Something went wrong", isPresented: failureAlertBinding) {
            Button("Retry") {
                viewModel.retryLastBarcode()
            }
            Button("Close", role: .cancel) {
                dismiss()
            }
        } message: {
            if case .failure(let message) = viewModel.state {
                Text(message)
            }
        }
        .onAppear {
            viewModel.execute()
        }
//        .task {
//            await viewModel.start()
//        }
        .background(Theme.Colors.background)
    }

    private var formattedExtractionDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: viewModel.extractionDraft.expiryDate)
    }

    private var bindingDraft: Binding<ProductDraft>? {
        guard viewModel.draft != nil else { return nil }
        return Binding(
            get: { viewModel.draft ?? ProductDraft.emptyManualDraft() },
            set: { viewModel.draft = $0 }
        )
    }

    private var successAlertBinding: Binding<Bool> {
        Binding(
            get: {
                if case .success = viewModel.state {
                    return true
                }
                return false
            },
            set: { isPresented in
                if isPresented == false {
                    viewModel.closeFlow()
                }
            }
        )
    }

    private var failureAlertBinding: Binding<Bool> {
        Binding(
            get: {
                if case .failure = viewModel.state {
                    return true
                }
                return false
            },
            set: { _ in }
        )
    }

    private var barcodeScannerSheet: some View {
        BarcodeScannerView(
            configuration: .continuous,
            onCancel: { viewModel.isBarcodeScannerPresented = false },
            onBarcodeDetected: { scanned in
                viewModel.isBarcodeScannerPresented = false
                let barcode = Barcode(value: scanned.payload, symbology: .init(value: scanned.symbology))
                viewModel.onDetectedBarcode(barcode)
            }
        )
    }

    private var cameraScannerSheet: some View {
        CameraScannerView(
            onCancel: {
                viewModel.isImageCapturePresented = false
            },
            onComplete: { result in
                viewModel.isImageCapturePresented = false
                let images = result.imagesCaptured
//                viewModel.submitCapturedImages(images)
//                appState.navigate(to: .productReview(images))
                viewModel.navigateToProductReview(images)
            }
        )
    }
}

private extension ProductDraft {
    static func emptyManualDraft() -> ProductDraft {
        ProductDraft(
            id: UUID().uuidString,
            source: .manual,
            isEditable: true,
            barcode: nil,
            catalog: nil,
            title: nil,
            brand: nil,
            description: nil,
            categories: nil,
            category: nil,
            productDetail: nil,
            size: nil,
            images: [],
            quantity: 1,
            numberOfItems: 1,
            unit: "Count",
            dateEntries: [],
            notes: nil,
            lockedFields: [],
            fieldConfidences: [:]
        )
    }
}

#if DEBUG
#Preview {
//    AddProductFlowRootView(
//        viewModel: AddProductModuleAssembler()
//    )
}
#endif
