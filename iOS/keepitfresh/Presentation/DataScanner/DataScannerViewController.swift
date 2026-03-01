//
//
//  DataScannerViewController.swift
//  keepitfresh
//
//  Created by musadhikh on 17/2/26.
//  Summary: DataScannerViewController
//
    

import SwiftUI
import VisionKit

struct DataScannerController: UIViewControllerRepresentable {
    @Binding var recognizedItems: [RecognizedItem]
    @Binding var isScanning: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.ean13]), .text()],
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if isScanning {
            do {
                try uiViewController.startScanning()
                Task { await updateViaAsyncStream(controller: uiViewController) }
                
            } catch {
                logger.error("live scan failed: \(error)")
            }
        } else {
            uiViewController.stopScanning()
        }
    }
    
    private func updateViaAsyncStream(controller: DataScannerViewController) async {
        let stream = controller.recognizedItems
        
        for await newItems in stream {
            for item in newItems {
                if let firstIndex = recognizedItems.firstIndex(where: { $0.id == item.id }) {
                    recognizedItems[firstIndex] = item
                } else {
                    recognizedItems.append(item)
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, Sendable {
        let parent: DataScannerController
        
        init(parent: DataScannerController) {
            self.parent = parent
        }
    }
}

extension DataScannerController.Coordinator: DataScannerViewControllerDelegate {}

extension DataScannerController: Sendable {}
