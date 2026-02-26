//
//  BarcodeScannerView.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Provides a full-screen low-latency barcode scanner UI optimized for fast interactions.
//

import SwiftUI
import UIKit

public struct BarcodeScannerView: View {
    @Environment(\.dismiss) private var dismiss

    private let configuration: BarcodeScannerConfiguration
    private let onCancel: (() -> Void)?
    private let onBarcodeDetected: @MainActor (ScannedBarcode) -> Void

    @State private var availability: BarcodeScannerAvailability = .ready
    @State private var latestBarcode: ScannedBarcode?
    @State private var hasForwardedDetection = false
    @State private var reticlePulse = false

    public init(
        configuration: BarcodeScannerConfiguration = BarcodeScannerConfiguration(),
        onCancel: (() -> Void)? = nil,
        onBarcodeDetected: @escaping @MainActor (ScannedBarcode) -> Void
    ) {
        self.configuration = configuration
        self.onCancel = onCancel
        self.onBarcodeDetected = onBarcodeDetected
    }

    public var body: some View {
        ZStack {
            BarcodeScannerControllerView(
                configuration: configuration,
                onAvailabilityChange: { availability in
                    self.availability = availability
                },
                onBarcodeDetected: { barcode in
                    guard hasForwardedDetection == false else {
                        return
                    }

                    hasForwardedDetection = true
                    latestBarcode = barcode
                    onBarcodeDetected(barcode)
                }
            )
            .ignoresSafeArea()

            LinearGradient(
                colors: [
                    .black.opacity(0.45),
                    .clear,
                    .black.opacity(0.68)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)

            VStack(spacing: 0) {
                ScannerTopBar(
                    onClose: {
                        if let onCancel {
                            onCancel()
                        } else {
                            dismiss()
                        }
                    }
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()

                ScannerReticleView(isPulsing: reticlePulse)
                    .frame(width: 250, height: 170)

                ScannerGuidanceView(isAvailable: availability == .ready)
                    .padding(.top, 18)

                Spacer()

                if let latestBarcode {
                    LatestBarcodeCard(scannedBarcode: latestBarcode)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }

            if availability != .ready {
                ScannerUnavailableView(
                    message: availability.message,
                    onClose: {
                        if let onCancel {
                            onCancel()
                        } else {
                            dismiss()
                        }
                    }
                )
                .padding(.horizontal, 20)
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
        .onAppear {
            reticlePulse = true
        }
        .animation(.easeInOut(duration: 0.2), value: latestBarcode)
    }
}

private struct ScannerTopBar: View {
    let onClose: () -> Void

    var body: some View {
        HStack {
            Spacer()

            Button("Close Scanner", systemImage: BarcodeScannerIcon.close.systemName) {
                onClose()
            }
            .labelStyle(.iconOnly)
            .font(.title3)
            .foregroundStyle(.white)
            .frame(width: 44, height: 44)
            .background(.black.opacity(0.35))
            .clipShape(.rect(cornerRadius: 22))
        }
    }
}

private struct ScannerReticleView: View {
    let isPulsing: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(.white.opacity(0.95), lineWidth: 2)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black.opacity(0.15))
            }
            .scaleEffect(isPulsing ? 1.02 : 0.98)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isPulsing)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.white.opacity(0.4), style: StrokeStyle(lineWidth: 1, dash: [8, 6]))
                    .padding(14)
            }
    }
}

private struct ScannerGuidanceView: View {
    let isAvailable: Bool

    var body: some View {
        Text(isAvailable ? "Point the camera at a barcode" : "Scanner unavailable")
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.black.opacity(0.35))
            .clipShape(.rect(cornerRadius: 999))
    }
}

private struct LatestBarcodeCard: View {
    let scannedBarcode: ScannedBarcode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Latest Detection")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(scannedBarcode.payload)
                .font(.title3)
                .bold()
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .foregroundStyle(.primary)

            HStack {
                Text(scannedBarcode.symbology.uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Button("Copy", systemImage: BarcodeScannerIcon.copy.systemName) {
                    UIPasteboard.general.string = scannedBarcode.payload
                }
                .font(.caption)
                .buttonStyle(.bordered)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 16))
    }
}

private struct ScannerUnavailableView: View {
    let message: String
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: BarcodeScannerIcon.warning.systemName)
                .font(.largeTitle)
                .foregroundStyle(.white)

            Text("Scanner Unavailable")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)

            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.85))

            Button("Close", action: onClose)
                .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.72))
        .clipShape(.rect(cornerRadius: 24))
    }
}

private enum BarcodeScannerIcon: String {
    case close = "xmark"
    case copy = "doc.on.doc"
    case warning = "exclamationmark.triangle.fill"

    var systemName: String { rawValue }
}

#if DEBUG
#Preview {
    BarcodeScannerView { _ in }
}
#endif
