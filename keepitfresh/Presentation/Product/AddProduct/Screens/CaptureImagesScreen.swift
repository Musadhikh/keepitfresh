//
//  CaptureImagesScreen.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Placeholder 1-3 image capture screen returning image data payloads.
//

import SwiftUI
import PhotosUI
import CameraModule
import ImageDataModule

struct ImagesCaptured: ImageData,  Identifiable, Equatable, Sendable {
    var cgImage: CGImage
    var orientation: CGImagePropertyOrientation
    
    public let id: UUID
    public let image: UIImage
    public let boundingBox: CGRect
    public let imageSize: CGSize
    
    public init(
        id: UUID,
        image: UIImage,
        boundingBox: CGRect,
        imageSize: CGSize
    ) {
        self.id = id
        self.image = image
        self.boundingBox = boundingBox
        self.imageSize = imageSize
        
        self.cgImage = image.cgImage!
        self.orientation = CGImagePropertyOrientation(image.imageOrientation)
    }
}

struct CaptureImagesScreen: View {
    let maxImages: Int
    let onSubmit: ([ImagesCaptured]) -> Void
    let onBack: () -> Void

    @State private var capturedImages: [CameraCapturedImage] = []
    
    @State private var selectedImageIndex: Int = 0
    @State private var showCamera: Bool = false
    

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
            Text("Capture Images")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)

            Text("Select 1-\(maxImages) images (front, back, date area).")
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)

            Text("Selected: \(capturedImages.count)/\(maxImages)")
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)

            if capturedImages.isNotEmpty {
                ProductOverviewImageCard(images: capturedImages.map(\.image), selectedImageIndex: $selectedImageIndex)
            }
            
            HStack(spacing: Theme.Spacing.s12) {
                
                Button("Capture  Image", icon: .cameraScanner) {
                    showCamera = true
                }

                Button("Clear") {
                    capturedImages.removeAll()
                }
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
            }

            Spacer()

            Button("Extract Details") {
                let images = capturedImages.map {
                    ImagesCaptured(
                        id: $0.id,
                        image: $0.image,
                        boundingBox: $0.boundingBox,
                        imageSize: $0.imageSize
                    )
                }
                onSubmit(images)
            }
            .primaryButtonStyle(height: 48)
            .disabled(capturedImages.isEmpty)
        }
        .padding(Theme.Spacing.s16)
        .background(Theme.Colors.background)
            .fullScreenCover(isPresented: $showCamera) {
            CameraScannerView {
                showCamera = false
            } onComplete: { capturedImages in
                self.capturedImages = Array(capturedImages.prefix(maxImages))
                showCamera = false
            }
        }
    }
}
