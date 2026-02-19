//
//  CameraScannerService.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Implements camera session lifecycle, photo capture, library appends, and low-light flash behavior.
//

import AVFoundation
import Foundation
import ImageIO
import Photos
import UIKit
import os
let logger = Logger(subsystem: "com.mus.keepitfresh", category: "Camera")
@MainActor
public final class CameraScannerService: NSObject {
    public var onUpdate: (@MainActor () -> Void)?
    
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let sessionQueue = DispatchQueue(label: "com.keepitfresh.camera.session")
    
    private var captureContinuation: CheckedContinuation<CameraCapturedImage, Error>?
    private var isConfigured = false
    private var isRunning = false
    private var hasFlashHardware = false
    private var isFlashManuallyManaged = false
    
    public private(set) var capturedImages: [CameraCapturedImage] = []
    public private(set) var flashMode: CameraFlashMode = .off
    public private(set) var isLowLight = false
    
    public var session: AVCaptureSession {
        captureSession
    }
    
    public override init() {
        super.init()
    }
    
    public func requestPermissions() async -> Bool {
        let cameraPermission = await requestCameraPermission()
        let photosPermission = await requestPhotoLibraryPermission()
        return cameraPermission && photosPermission
    }
    
    public func start() async throws {
        guard await requestCameraPermission() else {
            throw CameraScannerServiceError.permissionDenied
        }
        
        if !isConfigured {
            try await configureSession()
        }
        try await startRunningSession()
    }
    
    public func stop() async {
        await withCheckedContinuation { continuation in
            sessionQueue.async {
                if self.captureSession.isRunning {
                    self.captureSession.stopRunning()
                }
                Task { @MainActor in
                    self.isRunning = false
                    continuation.resume()
                }
            }
        }
    }
    
    public func toggleFlash() {
        flashMode = flashMode == .on ? .off : .on
        isFlashManuallyManaged = true
        onUpdate?()
    }
    
    public func capturePhoto() async throws -> CameraCapturedImage {
        guard isRunning else {
            throw CameraScannerServiceError.sessionNotRunning
        }
        guard captureContinuation == nil else {
            throw CameraScannerServiceError.captureInProgress
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            captureContinuation = continuation
            
            let settings = AVCapturePhotoSettings()
            settings.photoQualityPrioritization = .speed
            settings.flashMode = effectiveFlashMode()
            photoOutput.capturePhoto(with: settings, delegate: self)
        }
    }
    
    public func appendLibraryImage(_ image: UIImage) {
        let normalizedImage = image.normalizedOrientation()
        let imageSize = normalizedImage.size
        let item = CameraCapturedImage(
            id: UUID(),
            image: normalizedImage,
            boundingBox: CGRect(origin: .zero, size: imageSize),
            imageSize: imageSize
        )
        capturedImages.append(item)
        onUpdate?()
    }
    
    public func removeCapturedImage(id: UUID) {
        capturedImages.removeAll { $0.id == id }
        onUpdate?()
    }
    
    public func capturedResult() -> [CameraCapturedImage] {
        capturedImages
    }
    
    public func clearCapturedImages() {
        capturedImages.removeAll()
        onUpdate?()
    }
    
    private func requestCameraPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        case .denied, .restricted:
            return false
        @unknown default:
            return false
        }
    }
    
    private func requestPhotoLibraryPermission() async -> Bool {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .authorized, .limited:
            return true
        case .notDetermined:
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return newStatus == .authorized || newStatus == .limited
        case .denied, .restricted:
            return false
        @unknown default:
            return false
        }
    }
    
    private func configureSession() async throws {
        try await withCheckedThrowingContinuation { continuation in
            sessionQueue.async {
                do {
                    self.captureSession.beginConfiguration()
                    self.captureSession.sessionPreset = .photo
                    
                    if let existingInput = self.captureSession.inputs.first {
                        self.captureSession.removeInput(existingInput)
                    }
                    if let existingOutput = self.captureSession.outputs.first(where: { $0 is AVCapturePhotoOutput }) {
                        self.captureSession.removeOutput(existingOutput)
                    }
                    if let existingVideoOutput = self.captureSession.outputs.first(where: { $0 is AVCaptureVideoDataOutput }) {
                        self.captureSession.removeOutput(existingVideoOutput)
                    }
                    
                    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                        throw CameraScannerServiceError.cameraUnavailable
                    }
                    
                    try device.lockForConfiguration()
                    if device.isFocusModeSupported(.continuousAutoFocus) {
                        device.focusMode = .continuousAutoFocus
                    } else if device.isFocusModeSupported(.autoFocus) {
                        device.focusMode = .autoFocus
                    }
                    
                    if device.isExposureModeSupported(.continuousAutoExposure) {
                        device.exposureMode = .continuousAutoExposure
                    } else if device.isExposureModeSupported(.autoExpose) {
                        device.exposureMode = .autoExpose
                    }
                    
                    if device.isAutoFocusRangeRestrictionSupported {
                        device.autoFocusRangeRestriction = .near
                    }
                    device.unlockForConfiguration()
                    
                    logger.debug("device focus mode: \(device.focusMode.rawValue)")
                    logger.debug("device exposure mode: \(device.exposureMode.rawValue)")
                    logger.debug("device auto focus range restriction mode: \(device.autoFocusRangeRestriction.rawValue)")
                    
                    self.hasFlashHardware = device.hasFlash
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    guard self.captureSession.canAddInput(input) else {
                        throw CameraScannerServiceError.sessionConfigurationFailed
                    }
                    self.captureSession.addInput(input)
                    
                    guard self.captureSession.canAddOutput(self.photoOutput) else {
                        throw CameraScannerServiceError.sessionConfigurationFailed
                    }
                    self.captureSession.addOutput(self.photoOutput)
                    self.photoOutput.maxPhotoQualityPrioritization = .quality
                    
                    self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
                    self.videoDataOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
                    if self.captureSession.canAddOutput(self.videoDataOutput) {
                        self.captureSession.addOutput(self.videoDataOutput)
                    }
                    
                    self.captureSession.commitConfiguration()
                    Task { @MainActor in
                        self.isConfigured = true
                        continuation.resume()
                    }
                } catch {
                    self.captureSession.commitConfiguration()
                    Task { @MainActor in
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    private func startRunningSession() async throws {
        try await withCheckedThrowingContinuation { continuation in
            sessionQueue.async {
                if !self.captureSession.isRunning {
                    self.captureSession.startRunning()
                }
                Task { @MainActor in
                    self.isRunning = true
                    continuation.resume()
                }
            }
        }
    }
    
    private func effectiveFlashMode() -> AVCaptureDevice.FlashMode {
        guard hasFlashHardware else {
            return .off
        }
        
        if flashMode == .on || isLowLight {
            return .on
        }
        
        return .off
    }
    
    private func handleAmbientBrightness(_ brightnessValue: Double) {
        let lowLightDetected = brightnessValue < -1.1
        if isLowLight != lowLightDetected {
            isLowLight = lowLightDetected
            if lowLightDetected && !isFlashManuallyManaged && flashMode == .off && hasFlashHardware {
                flashMode = .on
            }
            onUpdate?()
        }
    }
}

extension CameraScannerService: AVCapturePhotoCaptureDelegate {
    nonisolated public func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        let photoData = photo.fileDataRepresentation()

        Task { @MainActor in
            guard let continuation = self.captureContinuation else {
                return
            }
            self.captureContinuation = nil
            
            if let error {
                continuation.resume(throwing: error)
                return
            }
            guard let data = photoData,
                  let image = UIImage(data: data) else {
                continuation.resume(throwing: CameraScannerServiceError.photoDataUnavailable)
                return
            }
            
            let normalizedImage = image.normalizedOrientation()
            let imageSize = normalizedImage.size
            let item = CameraCapturedImage(
                id: UUID(),
                image: normalizedImage,
                boundingBox: CGRect(origin: .zero, size: imageSize),
                imageSize: imageSize
            )
            
            self.capturedImages.append(item)
            self.onUpdate?()
            continuation.resume(returning: item)
        }
    }
}

extension CameraScannerService: AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated public func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let metadata = CMCopyDictionaryOfAttachments(
            allocator: kCFAllocatorDefault,
            target: sampleBuffer,
            attachmentMode: kCMAttachmentMode_ShouldPropagate
        ) as? [String: Any],
        let exif = metadata[kCGImagePropertyExifDictionary as String] as? [String: Any],
        let brightnessValue = exif[kCGImagePropertyExifBrightnessValue as String] as? Double else {
            return
        }
        
        Task { @MainActor in
            self.handleAmbientBrightness(brightnessValue)
        }
    }
}

private extension UIImage {
    func normalizedOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? self
    }
}
