//
//  AddProductScanLabelView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S2 scan-label screen with capture controls and detection chips.
//

import SwiftUI

struct AddProductScanLabelView: View {
    let maxImages: Int
    let detectedName: String
    let detectedDateText: String
    let detectedBarcodeText: String
    let isTorchEnabled: Bool
    let isAutoDetectEnabled: Bool
    let onToggleTorch: () -> Void
    let onToggleAutoDetect: (Bool) -> Void
    let onCapture: () -> Void
    let onBack: () -> Void

    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                header
                scanFrame
                chips
                Spacer(minLength: Theme.Spacing.s16)
                controls
            }
            .padding(Theme.Spacing.s16)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            Button(action: onBack) {
                HStack(spacing: Theme.Spacing.s8) {
                    Image(icon: .productBack)
                    Text("Back")
                }
                .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
            }
            .buttonStyle(.plain)

            Text("Scan Label")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            Text("Align label inside frame")
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
    }

    private var scanFrame: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = min(proxy.size.height, 320)

            ZStack {
                RoundedRectangle(cornerRadius: Theme.Radius.r24)
                    .fill(Theme.Colors.surfaceAlt)

                RoundedRectangle(cornerRadius: Theme.Radius.r24)
                    .stroke(Theme.Colors.border, lineWidth: 1)

                VStack {
                    HStack {
                        cornerMark(rotation: 0)
                        Spacer()
                        cornerMark(rotation: 90)
                    }
                    Spacer()
                    HStack {
                        cornerMark(rotation: 270)
                        Spacer()
                        cornerMark(rotation: 180)
                    }
                }
                .padding(Theme.Spacing.s16)

                Rectangle()
                    .fill(.black.opacity(0.18))
                    .blendMode(.plusLighter)
                    .clipShape(.rect(cornerRadius: Theme.Radius.r24))
            }
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Radius.r24)
                    .stroke(Theme.Colors.accent.opacity(0.6), lineWidth: 1)
            )
        }
        .frame(height: 320)
    }

    private var chips: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            chip(icon: .productDates, text: "Use by: \(detectedDateText)")
            chip(icon: .tag, text: detectedName)
            chip(icon: .productBarcode, text: detectedBarcodeText)
        }
    }

    private var controls: some View {
        VStack(spacing: Theme.Spacing.s12) {
            Button(action: onCapture) {
                HStack(spacing: Theme.Spacing.s8) {
                    Image(icon: .cameraScanner)
                    Text("Capture")
                }
            }
            .primaryButtonStyle(height: 50)

            HStack(spacing: Theme.Spacing.s12) {
                Button(action: onToggleTorch) {
                    HStack(spacing: Theme.Spacing.s8) {
                        Image(icon: .torch)
                        Text(isTorchEnabled ? "Torch On" : "Torch")
                    }
                    .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 42)
                    .background(Theme.Colors.surface)
                    .clipShape(.rect(cornerRadius: Theme.Radius.r16))
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.r16)
                            .stroke(Theme.Colors.border, lineWidth: Theme.Border.hairline)
                    )
                }
                .buttonStyle(.plain)

                Toggle(isOn: Binding(get: { isAutoDetectEnabled }, set: onToggleAutoDetect)) {
                    Text("Auto-detect")
                        .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textPrimary)
                }
                .padding(.horizontal, Theme.Spacing.s12)
                .frame(height: 42)
                .background(Theme.Colors.surface)
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: Theme.Border.hairline)
                )
            }
        }
    }

    private func chip(icon: Theme.Icon, text: String) -> some View {
        HStack(spacing: Theme.Spacing.s8) {
            Image(icon: icon)
                .foregroundStyle(Theme.Colors.accent)
            Text(text)
                .font(Theme.Fonts.body(12, weight: .medium, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textPrimary)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, Theme.Spacing.s8)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surface)
        .overlay(
            Capsule().stroke(Theme.Colors.border, lineWidth: Theme.Border.hairline)
        )
        .clipShape(.capsule)
    }

    private func cornerMark(rotation: Double) -> some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Theme.Colors.accent)
            .frame(width: 18, height: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .fill(Theme.Colors.accent)
                    .frame(width: 4, height: 18)
                    .offset(x: -7, y: 7)
            )
            .rotationEffect(.degrees(rotation))
    }
}
