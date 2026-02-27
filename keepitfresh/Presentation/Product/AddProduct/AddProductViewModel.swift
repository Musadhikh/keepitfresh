//
//  AddProductViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Main-actor view model that binds Add Product use case state to SwiftUI.
//

import Foundation

@MainActor
@Observable
final class AddProductViewModel {
    private let useCase: AddProductFlowUseCase
    private let initialBarcode: Barcode?
    private var observeTask: Task<Void, Never>?
    private var lastResolvedBarcode: Barcode?
    private var didResolveInitialBarcode = false

    private(set) var state: AddProductState = .idle
    var draft: ProductDraft?

    init(useCase: AddProductFlowUseCase, initialBarcode: Barcode? = nil) {
        self.useCase = useCase
        self.initialBarcode = initialBarcode
    }

    func start() async {
        if observeTask == nil {
            startObservingState()
        }
        await useCase.start()

        guard didResolveInitialBarcode == false, let initialBarcode else { return }
        didResolveInitialBarcode = true
        lastResolvedBarcode = initialBarcode
        await useCase.handleBarcode(initialBarcode)
    }

    func submitManualBarcode(_ rawValue: String) {
        let value = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard value.isEmpty == false else { return }
        let barcode = Barcode(value: value, symbology: .unknown)
        onDetectedBarcode(barcode)
    }

    func onDetectedBarcode(_ barcode: Barcode) {
        lastResolvedBarcode = barcode
        Task {
            await useCase.handleBarcode(barcode)
        }
    }

    func retryLastBarcode() {
        if let lastResolvedBarcode {
            onDetectedBarcode(lastResolvedBarcode)
        } else {
            Task {
                await useCase.resetAndScan()
            }
        }
    }

    func continueFromCatalog() {
        Task {
            await useCase.continueFromCatalogHit()
        }
    }

    func skipToCaptureImages() {
        Task {
            await useCase.skipBarcodeAndCaptureImages()
        }
    }

    func submitCapturedImages(_ images: [ImagesCaptured]) {
        Task {
            await useCase.handleCapturedImages(images)
        }
    }

    func quickAddOne() {
        Task {
            await useCase.quickAddOne()
        }
    }

    func quickAddBatch() {
        Task {
            await useCase.quickAddBatch()
        }
    }

    func editDates() {
        Task {
            await useCase.editDatesForInventoryHit()
        }
    }

    func openManualDraft() {
        Task {
            await useCase.openManualEntry()
        }
    }

    func saveDraft() {
        guard let draft else { return }
        Task {
            await useCase.saveDraft(draft)
        }
    }

    func saveExtractedProduct(_ product: Product, numberOfItems: Int) {
        let draft = makeDraft(from: product, numberOfItems: numberOfItems)
        self.draft = draft
        Task {
            await useCase.saveDraft(draft)
        }
    }

    func saveAndAddAnother() {
        saveDraft()
        Task {
            await useCase.resetAndScan()
        }
    }

    func startAnother() {
        Task {
            await useCase.resetAndScan()
        }
    }

    private func startObservingState() {
        let useCase = useCase
        observeTask = Task { [weak self] in
            let stream = await useCase.observeState()
            for await nextState in stream {
                if Task.isCancelled {
                    break
                }
                guard let self else {
                    break
                }
                self.state = nextState
                if case .reviewing(let draft, _) = nextState {
                    self.draft = draft
                } else if case .manualEntry(let draft) = nextState {
                    self.draft = draft
                }
            }
        }
    }

    private func makeDraft(from product: Product, numberOfItems: Int) -> ProductDraft {
        let normalizedItemCount = max(1, numberOfItems)
        let categories = makeCategories(from: product.category)

        return ProductDraft(
            id: product.id,
            source: .aiExtraction,
            isEditable: true,
            barcode: product.barcode,
            catalog: nil,
            title: product.title,
            brand: product.brand,
            description: product.shortDescription,
            categories: categories,
            category: product.category,
            productDetail: product.productDetail,
            size: nil,
            images: [],
            quantity: normalizedItemCount,
            numberOfItems: normalizedItemCount,
            unit: nil,
            dateEntries: [],
            notes: nil,
            lockedFields: [],
            fieldConfidences: [:]
        )
    }

    private func makeCategories(from category: ProductCategory) -> [String] {
        if let subCategory = category.subCategory?.trimmingCharacters(in: .whitespacesAndNewlines),
           subCategory.isEmpty == false {
            return [category.main.rawValue, subCategory]
        }

        return [category.main.rawValue]
    }
}
