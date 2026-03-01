//
//  CameraScannerViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Coordinates camera service operations and presentation state for camera scanner UI.
//

import Foundation
import Observation
import PhotosUI
import AVFoundation
import UIKit
import SwiftUI

@MainActor
@Observable
final class CameraScannerViewModel {
    private let cameraService: CameraScannerService
    
    private(set) var capturedImages: [CameraCapturedImage] = []
    private(set) var flashMode: CameraFlashMode = .off
    private(set) var isLowLight = false
    private(set) var isCaptureInProgress = false
    private(set) var isPermissionDenied = false
    var showThumbnailCarousel = false
    var selectedImageForFullscreen: CameraCapturedImage?
    var errorMessage: String?
    
    init(cameraService: CameraScannerService) {
        self.cameraService = cameraService
        self.cameraService.onUpdate = { [weak self] in
            self?.syncStateFromService()
        }
    }
    
    var session: AVCaptureSession {
        cameraService.session
    }
    
    var hasCaptures: Bool {
        !capturedImages.isEmpty
    }
    
    var latestCapturedImagesForStack: [CameraCapturedImage] {
        Array(capturedImages.suffix(3))
    }
    
    func onAppear() async {
        let permissionsGranted = await cameraService.requestPermissions()
        guard permissionsGranted else {
            isPermissionDenied = true
            return
        }
        
        do {
            try await cameraService.start()
            syncStateFromService()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func onDisappear() async {
        await cameraService.stop()
    }
    
    func capturePhoto() async {
        guard !isCaptureInProgress else { return }
        
        isCaptureInProgress = true
        defer { isCaptureInProgress = false }
        
        do {
            _ = try await cameraService.capturePhoto()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            syncStateFromService()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func addImagesFromPhotoPicker(_ items: [PhotosPickerItem]) async {
        guard !items.isEmpty else {
            return
        }

        var loadedResults: [(index: Int, data: Data?, errorMessage: String?)] = []
        await withTaskGroup(of: (Int, Data?, String?).self) { group in
            for (index, item) in items.enumerated() {
                group.addTask {
                    do {
                        let data = try await item.loadTransferable(type: Data.self)
                        return (index, data, nil)
                    } catch {
                        return (index, nil, error.localizedDescription)
                    }
                }
            }

            for await result in group {
                loadedResults.append((index: result.0, data: result.1, errorMessage: result.2))
            }
        }

        for result in loadedResults.sorted(by: { $0.index < $1.index }) {
            if let data = result.data {
                do {
                    try await cameraService.appendLibraryImageData(data)
                } catch {
                    if errorMessage == nil {
                        errorMessage = error.localizedDescription
                    }
                }
            } else if let message = result.errorMessage, errorMessage == nil {
                errorMessage = message
            }
        }

        syncStateFromService()
    }
    
    func toggleFlash() {
        cameraService.toggleFlash()
        syncStateFromService()
    }
    
    func deleteCapturedImage(id: UUID) {
        cameraService.removeCapturedImage(id: id)
        if selectedImageForFullscreen?.id == id {
            selectedImageForFullscreen = nil
        }
        syncStateFromService()
    }
    
    func completeCapture() -> [CameraCapturedImage] {
        cameraService.capturedResult()
    }
    
    func openFullscreen(for image: CameraCapturedImage) {
        selectedImageForFullscreen = image
    }
    
    func closeFullscreen() {
        selectedImageForFullscreen = nil
    }
    
    private func syncStateFromService() {
        capturedImages = cameraService.capturedResult()
        flashMode = cameraService.flashMode
        isLowLight = cameraService.isLowLight
    }
}
