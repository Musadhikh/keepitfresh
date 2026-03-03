//
//  AddProductFlowRootViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Main-actor view model that binds Add Product flow state and drives S1-S6 presentation routing.
//

import Foundation
import ImageDataModule

enum AddProductFlowType: Hashable {
    case barcode(Barcode)
    case imageCapture([ImagesCaptured])
}

@MainActor
@Observable
final class AddProductFlowRootViewModel {
    private let useCase: AddProductFlowUseCase
    private let flowType: AddProductFlowType
    private let imageProcessor: ImageProcessor
    private var observeTask: Task<Void, Never>?
    private var extractionTask: Task<Void, Never>?
    private var lastResolvedBarcode: Barcode?
    private var didResolveInitialBarcode = false

    private(set) var state: AddProductState = .idle
    private(set) var screen: AddProductFlowScreen = .addActionSheet

    var draft: ProductDraft?
    var extractionDraft = AddProductExtractionReviewDraft()

    var isBarcodeScannerPresented = false
    var isImageCapturePresented = false
    var isSaving: Bool {
        if case .saving = state {
            return true
        }
        return false
    }

    init(useCase: AddProductFlowUseCase, type: AddProductFlowType) {
        self.useCase = useCase
        self.flowType = type
        self.imageProcessor = ImageProcessor(instruction: .inventoryAssistant)
    }
    
    func start() async {
        if observeTask == nil {
            startObservingState()
        }
        await useCase.start()

        await startFlowType()
    }

    func closeFlow() {
        screen = .addActionSheet
    }

    func openScanLabel() {
        screen = .scanLabel
        Task {
            await useCase.skipBarcodeAndCaptureImages()
        }
    }

    func openScanBarcode() {
        isBarcodeScannerPresented = true
    }

    func openProductSearch() {
        screen = .productSearch
    }

    func openManualAdd() {
        Task {
            await useCase.openManualEntry()
        }
    }

    func quickAddPreset() {
        Task {
            await useCase.openManualEntry(prefilledTitle: "Eggs")
        }
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

    func submitCapturedImages(_ images: [ImagesCaptured]) {
        extractionTask?.cancel()
        extractionTask = Task {
            await useCase.handleCapturedImages(images)
            await runExtraction(for: images)
        }
    }

    func continueFromExtractionReview() {
        let convertedDraft = AddProductFlowDraftMapper.makeDraft(from: extractionDraft)
        draft = convertedDraft
        Task {
            await useCase.reviewDraft(convertedDraft, isEditable: true)
        }
    }

    func continueFromManualAdd() {
        guard let draft else { return }
        Task {
            await useCase.reviewDraft(draft, isEditable: true)
        }
    }

    func selectSearchResult(_ row: AddProductSearchViewModel.SearchResultRow) {
        let catalogItem = AddProductFlowDraftMapper.makeCatalogItem(from: row.product)
        Task {
            await useCase.reviewCatalogProduct(catalogItem, source: .catalogLocal)
        }
    }

    func saveDraftOnly() {
        guard let draft else { return }
        Task {
            await useCase.saveDraft(draft)
        }
    }

    func addToInventory() {
        guard let draft else { return }
        Task {
            await useCase.saveDraft(draft)
        }
    }

    func startAnother() {
        Task {
            await useCase.resetAndScan()
        }
    }

    func backFromConfirm() {
        if case .reviewing = state {
            screen = .addActionSheet
            Task {
                await useCase.resetAndScan()
            }
        } else {
            screen = .addActionSheet
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
                self.reducePresentationState(with: nextState)
            }
        }
    }

    private func reducePresentationState(with nextState: AddProductState) {
        switch nextState {
        case .idle, .scanning:
            screen = .addActionSheet
        case .resolving:
            break
        case .captureImages:
            screen = .scanLabel
            isImageCapturePresented = true
        case .extracting:
            seedExtractionDraftIfNeeded()
            screen = .extractionReview
        case .manualEntry(let draft):
            self.draft = draft
            screen = .manualAdd
        case .reviewing(let draft, _):
            self.draft = draft
            screen = .confirmPurchase
        case .success:
            screen = .addActionSheet
        case .barcodeNotFound:
            screen = .addActionSheet
        case .inventoryFound, .catalogFound, .saving, .failure:
            break
        }
    }

    private func seedExtractionDraftIfNeeded() {
        if extractionDraft.productName.isEmpty == false {
            return
        }
        extractionDraft = AddProductExtractionReviewDraft(
            productName: "",
            brand: "",
            category: .food,
            subCategory: "",
            expiryDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(),
            manufacturedDate: Date(),
            includeManufacturedDate: false,
            barcode: lastResolvedBarcode?.value ?? ""
        )
    }

    private func runExtraction(for images: [ImagesCaptured]) async {
        do {
            var latest: ExtractedData.PartiallyGenerated?
            let stream = imageProcessor.inventoryData(images: images)
            for try await partial in stream {
                if Task.isCancelled { return }
                latest = partial
            }
            if let latest {
                applyExtraction(latest)
            }
        } catch {
            logger.error("Label extraction failed: \(error)")
        }
    }

    private func applyExtraction(_ extracted: ExtractedData.PartiallyGenerated) {
        let fallbackExpiry = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        let parsedDates = parseDates(from: extracted.dateInfo)
        let expiryDate = parsedDates.expiry ?? parsedDates.useBy ?? parsedDates.bestBefore ?? fallbackExpiry
        let manufacturedDate = parsedDates.manufactured ?? parsedDates.packed ?? Date()
        let includeManufacturedDate = parsedDates.manufactured != nil || parsedDates.packed != nil

        extractionDraft = AddProductExtractionReviewDraft(
            productName: extracted.title?.trimmingCharacters(in: .whitespacesAndNewlines) ?? extractionDraft.productName,
            brand: extracted.brand?.trimmingCharacters(in: .whitespacesAndNewlines) ?? extractionDraft.brand,
            category: MainCategory(generated: extracted.category?.mainCategory),
            subCategory: extracted.category?.subCategory?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
            expiryDate: expiryDate,
            manufacturedDate: manufacturedDate,
            includeManufacturedDate: includeManufacturedDate,
            barcode: extracted.barcodeInfo?.barcode?.trimmingCharacters(in: .whitespacesAndNewlines)
                ?? lastResolvedBarcode?.value
                ?? extractionDraft.barcode
        )
    }

    private func parseDates(from entries: [ExtractedDateInfo.PartiallyGenerated]?) -> (
        expiry: Date?,
        useBy: Date?,
        bestBefore: Date?,
        manufactured: Date?,
        packed: Date?
    ) {
        var expiry: Date?
        var useBy: Date?
        var bestBefore: Date?
        var manufactured: Date?
        var packed: Date?

        for entry in entries ?? [] {
            guard
                let raw = entry.date?.trimmingCharacters(in: .whitespacesAndNewlines),
                raw.isNotEmpty,
                let parsedDate = parseDate(raw)
            else {
                continue
            }

            switch entry.dateType {
            case .expiry:
                expiry = expiry ?? parsedDate
            case .useBy:
                useBy = useBy ?? parsedDate
            case .bestBefore, .useBefore:
                bestBefore = bestBefore ?? parsedDate
            case .manufactured:
                manufactured = manufactured ?? parsedDate
            case .packed:
                packed = packed ?? parsedDate
            case nil:
                continue
            }
        }

        return (expiry, useBy, bestBefore, manufactured, packed)
    }

    private func parseDate(_ raw: String) -> Date? {
        let normalized = raw.replacingOccurrences(of: ".", with: "/")
            .replacingOccurrences(of: "-", with: "/")

        let formats = [
            "dd/MM/yyyy",
            "d/M/yyyy",
            "dd/MM/yy",
            "d/M/yy",
            "yyyy/MM/dd",
            "yyyy/M/d",
            "MM/dd/yyyy",
            "M/d/yyyy"
        ]

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current

        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: normalized) {
                return date
            }
        }
        return nil
    }
}

extension AddProductFlowRootViewModel {
    private func startFlowType() async {
        switch flowType {
            case .barcode(let barcode):
                didResolveInitialBarcode = true
                lastResolvedBarcode = barcode
                await useCase.handleBarcode(barcode)
            case .imageCapture(let images):
                submitCapturedImages(images)
        }
    }
}
