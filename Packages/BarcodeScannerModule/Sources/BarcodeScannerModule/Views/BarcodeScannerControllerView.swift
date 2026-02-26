//
//  BarcodeScannerControllerView.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Bridges a stable VisionKit DataScannerViewController into SwiftUI without restarting on updates.
//

import SwiftUI
import UIKit
import Vision
import VisionKit
import QuartzCore

struct BarcodeScannerControllerView: UIViewControllerRepresentable {
    let configuration: BarcodeScannerConfiguration
    let onAvailabilityChange: @MainActor (BarcodeScannerAvailability) -> Void
    let onBarcodeDetected: @MainActor (ScannedBarcode) -> Void

    func makeUIViewController(context: Context) -> BarcodeScannerContainerViewController {
        BarcodeScannerContainerViewController(
            configuration: configuration,
            onAvailabilityChange: onAvailabilityChange,
            onBarcodeDetected: onBarcodeDetected
        )
    }

    func updateUIViewController(_ uiViewController: BarcodeScannerContainerViewController, context: Context) {}

    static func dismantleUIViewController(
        _ uiViewController: BarcodeScannerContainerViewController,
        coordinator: ()
    ) {
        uiViewController.stopScanning()
    }
}

final class BarcodeScannerContainerViewController: UIViewController {
    private let configuration: BarcodeScannerConfiguration
    private let onAvailabilityChange: @MainActor (BarcodeScannerAvailability) -> Void
    private let onBarcodeDetected: @MainActor (ScannedBarcode) -> Void

    private var scannerViewController: DataScannerViewController?
    private var isScanningActive = false
    private var lastContinuousEmissionTime: CFTimeInterval = 0
    private var emissionGate: BarcodeEmissionGate
    private let feedbackGenerator = UINotificationFeedbackGenerator()

    init(
        configuration: BarcodeScannerConfiguration,
        onAvailabilityChange: @escaping @MainActor (BarcodeScannerAvailability) -> Void,
        onBarcodeDetected: @escaping @MainActor (ScannedBarcode) -> Void
    ) {
        self.configuration = configuration
        self.onAvailabilityChange = onAvailabilityChange
        self.onBarcodeDetected = onBarcodeDetected
        self.emissionGate = BarcodeEmissionGate(duplicateFilterInterval: configuration.duplicateFilterInterval)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureScannerIfPossible()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feedbackGenerator.prepare()
        startScanningIfNeeded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopScanning()
    }

    func stopScanning() {
        guard let scannerViewController, isScanningActive else { return }
        scannerViewController.stopScanning()
        isScanningActive = false
    }

    private func configureScannerIfPossible() {
        guard DataScannerViewController.isSupported else {
            reportAvailability(.unsupportedDevice)
            return
        }

        guard DataScannerViewController.isAvailable else {
            reportAvailability(.unavailable(reason: "Camera access is unavailable right now."))
            return
        }

        let configuredSymbologies = configuration.symbologies.map(\.visionKitValue)
        let scanner = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: configuredSymbologies)],
            qualityLevel: configuration.quality.visionKitValue,
            recognizesMultipleItems: configuration.mode == .continuous,
            isHighFrameRateTrackingEnabled: configuration.isHighFrameRateTrackingEnabled,
            isPinchToZoomEnabled: configuration.isPinchToZoomEnabled,
            isGuidanceEnabled: configuration.isGuidanceEnabled,
            isHighlightingEnabled: configuration.isHighlightingEnabled
        )

        scanner.delegate = self
        addChild(scanner)
        view.addSubview(scanner.view)
        scanner.view.frame = view.bounds
        scanner.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scanner.didMove(toParent: self)

        scannerViewController = scanner
        reportAvailability(.ready)
    }

    private func startScanningIfNeeded() {
        guard let scannerViewController, !isScanningActive else { return }

        do {
            try scannerViewController.startScanning()
            isScanningActive = true
        } catch {
            reportAvailability(.unavailable(reason: error.localizedDescription))
        }
    }

    private func handleRecognizedItems(_ items: [RecognizedItem]) {
        guard configuration.mode == .continuous,
              let firstBarcode = items.lazy.compactMap(mapToScannedBarcode(from:)).first else {
            return
        }
        
        let now = CACurrentMediaTime()
        if configuration.continuousDebounceInterval > 0,
           now - lastContinuousEmissionTime < configuration.continuousDebounceInterval {
            return
        }
        lastContinuousEmissionTime = now

        emitIfAllowed(firstBarcode)
    }

    private func emitIfAllowed(_ barcode: ScannedBarcode) {
        guard emissionGate.shouldEmit(payload: barcode.payload) else {
            return
        }

        if configuration.isHapticsEnabled {
            feedbackGenerator.notificationOccurred(.success)
            feedbackGenerator.prepare()
        }

        onBarcodeDetected(barcode)
    }

    private func mapToScannedBarcode(from item: RecognizedItem) -> ScannedBarcode? {
        guard case .barcode(let barcodeItem) = item,
              let payload = barcodeItem.payloadStringValue,
              !payload.isEmpty else {
            return nil
        }

        return ScannedBarcode(
            payload: payload,
            symbology: String(describing: barcodeItem.observation.symbology)
        )
    }

    private func reportAvailability(_ state: BarcodeScannerAvailability) {
        onAvailabilityChange(state)
    }
}

extension BarcodeScannerContainerViewController: DataScannerViewControllerDelegate {
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        guard let barcode = mapToScannedBarcode(from: item) else {
            return
        }
        emitIfAllowed(barcode)
    }

    func dataScanner(
        _ dataScanner: DataScannerViewController,
        didAdd addedItems: [RecognizedItem],
        allItems: [RecognizedItem]
    ) {
        handleRecognizedItems(addedItems)
    }

    func dataScanner(
        _ dataScanner: DataScannerViewController,
        didUpdate updatedItems: [RecognizedItem],
        allItems: [RecognizedItem]
    ) {
        // `didUpdate` is extremely chatty; handling only `didAdd` keeps UI responsive.
    }
}

private extension BarcodeScannerQuality {
    var visionKitValue: DataScannerViewController.QualityLevel {
        switch self {
        case .fast:
            return .fast
        case .balanced:
            return .balanced
        case .accurate:
            return .accurate
        }
    }
}

private extension BarcodeSymbology {
    var visionKitValue: VNBarcodeSymbology {
        switch self {
        case .ean8:
            return .ean8
        case .ean13:
            return .ean13
        case .upce:
            return .upce
        case .qr:
            return .qr
        case .code128:
            return .code128
        case .code39:
            return .code39
        case .dataMatrix:
            return .dataMatrix
        case .pdf417:
            return .pdf417
        case .itf14:
            return .itf14
        case .aztec:
            return .aztec
        }
    }
}
