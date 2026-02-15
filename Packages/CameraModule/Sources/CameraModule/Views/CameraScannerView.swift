//
//  CameraScannerView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Implements camera scanner UI with capture, flash, album picker, thumbnails, and fullscreen preview.
//

import PhotosUI
import SwiftUI
import UIKit

public struct CameraScannerView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let onCancel: (() -> Void)?
    private let onComplete: ([CameraCapturedImage]) -> Void
    
    @State private var viewModel: CameraScannerViewModel
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    
    public init(
        onCancel: (() -> Void)? = nil,
        onComplete: @escaping ([CameraCapturedImage]) -> Void
    ) {
        self.onCancel = onCancel
        self.onComplete = onComplete
        _viewModel = State(initialValue: CameraScannerViewModel(cameraService: CameraScannerService()))
    }
    
    public var body: some View {
        ZStack {
            CameraPreviewView(session: viewModel.session)
                .ignoresSafeArea()
                .background(Color.black)
            
            Color.black.opacity(0.18)
                .ignoresSafeArea()
            
            VStack {
                topBar
                Spacer()
                
                if viewModel.hasCaptures {
                    thumbnailStackButton
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                }
                
                bottomControls
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            if viewModel.showThumbnailCarousel {
                thumbnailCarouselOverlay
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if viewModel.isPermissionDenied {
                permissionOverlay
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onDisappear {
            Task { await viewModel.onDisappear() }
        }
        .onChange(of: selectedPhotoItems) { _, newItems in
            Task {
                await viewModel.addImagesFromPhotoPicker(newItems)
                selectedPhotoItems.removeAll()
            }
        }
        .alert("Camera Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.errorMessage = nil
                }
            })
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Something went wrong.")
        }
        .fullScreenCover(item: Binding(
            get: { viewModel.selectedImageForFullscreen },
            set: { image in
                if image == nil {
                    viewModel.closeFullscreen()
                }
            })
        ) { selectedImage in
            FullscreenImageView(
                image: selectedImage.image,
                onClose: { viewModel.closeFullscreen() }
            )
        }
    }
    
    private var topBar: some View {
        HStack {
            Spacer()
            Button {
                if let onCancel {
                    onCancel()
                } else {
                    dismiss()
                }
            } label: {
                Image(systemName: CameraScannerIcon.cancel.systemName)
                    .font(.system(size: 17, weight: .bold))
                    .frame(width: 40, height: 40)
                    .background(Color.white.opacity(0.16))
                    .foregroundStyle(Color.white)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
    }
    
    private var thumbnailStackButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.showThumbnailCarousel = true
            }
        } label: {
            ZStack(alignment: .topLeading) {
                ForEach(Array(viewModel.latestCapturedImagesForStack.enumerated()), id: \.element.id) { index, imageItem in
                    Image(uiImage: imageItem.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.65), lineWidth: 1)
                        }
                        .offset(x: CGFloat(index) * 6, y: CGFloat((2 - min(index, 2)) * 4))
                }
            }
            .frame(width: 66, height: 56, alignment: .leading)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Show captured image thumbnails")
    }
    
    private var bottomControls: some View {
        HStack(alignment: .center, spacing: 0) {
            PhotosPicker(
                selection: $selectedPhotoItems,
                maxSelectionCount: nil,
                matching: .images,
                photoLibrary: .shared()
            ) {
                CameraRoundControlButton(
                    iconName: CameraScannerIcon.photoLibrary.systemName,
                    size: 50,
                    cornerRadius: 12
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                Task {
                    await viewModel.capturePhoto()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 78, height: 78)
                        .overlay {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                        }
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 62, height: 62)
                }
                .scaleEffect(viewModel.isCaptureInProgress ? 0.94 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: viewModel.isCaptureInProgress)
            }
            .buttonStyle(.plain)
            .disabled(viewModel.isPermissionDenied || viewModel.isCaptureInProgress)
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 10) {
                Button {
                    viewModel.toggleFlash()
                } label: {
                    CameraRoundControlButton(
                        iconName: viewModel.flashMode == .on
                            ? CameraScannerIcon.flashOn.systemName
                            : CameraScannerIcon.flashOff.systemName,
                        size: 40,
                        cornerRadius: 20
                    )
                }
                .buttonStyle(.plain)
                
                Button {
                    onComplete(viewModel.completeCapture())
                    dismiss()
                } label: {
                    CameraRoundControlButton(
                        iconName: CameraScannerIcon.done.systemName,
                        size: 40,
                        cornerRadius: 20
                    )
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 4)
    }
    
    private var thumbnailCarouselOverlay: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Captured Images")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.showThumbnailCarousel = false
                        }
                    } label: {
                        Image(systemName: CameraScannerIcon.cancel.systemName)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(Color.white)
                            .frame(width: 24, height: 24)
                            .background(Color.white.opacity(0.18))
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.capturedImages) { imageItem in
                            VStack(spacing: 6) {
                                Button {
                                    viewModel.openFullscreen(for: imageItem)
                                } label: {
                                    Image(uiImage: imageItem.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(.rect(cornerRadius: 12))
                                }
                                .buttonStyle(.plain)
                                
                                Button("Remove", systemImage: CameraScannerIcon.delete.systemName) {
                                    viewModel.deleteCapturedImage(id: imageItem.id)
                                }
                                .font(.caption2)
                                .foregroundStyle(Color.white)
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 2)
                }
                .scrollIndicators(.hidden)
            }
            .padding(16)
            .background(Color.black.opacity(0.82))
            .clipShape(.rect(cornerRadius: 20))
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea()
    }
    
    private var permissionOverlay: some View {
        VStack(spacing: 16) {
            Image(systemName: CameraScannerIcon.warning.systemName)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.yellow)
            
            Text("Camera permission is required")
                .font(.headline)
                .foregroundStyle(Color.white)
            
            Text("Enable Camera and Photos access from Settings.")
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.85))
                .multilineTextAlignment(.center)
            
            Button("Open Settings") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(url)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.8))
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 20)
    }
}

private struct CameraRoundControlButton: View {
    let iconName: String
    let size: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(Color.white)
            .frame(width: size, height: size)
            .background(Color.white.opacity(0.14))
            .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

private struct FullscreenImageView: View {
    let image: UIImage
    let onClose: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            Button(action: onClose) {
                Image(systemName: CameraScannerIcon.cancel.systemName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(width: 34, height: 34)
                    .background(Color.black.opacity(0.6))
                    .clipShape(.rect(cornerRadius: 17))
            }
            .buttonStyle(.plain)
            .padding(.trailing, 16)
            .padding(.top, 12)
        }
    }
}
