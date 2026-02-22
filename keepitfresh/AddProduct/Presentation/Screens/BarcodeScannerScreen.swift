//
//  BarcodeScannerScreen.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Manual barcode/capture fallback screen used when no scanned barcode is provided by Home.
//

import SwiftUI

struct BarcodeScannerScreen: View {
    let onSubmitManualBarcode: (String) -> Void
    let onSkipToCamera: () -> Void

    @State private var manualBarcode = ""

    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()

            VStack(spacing: Theme.Spacing.s16) {
                Text("Scan Product Barcode")
                    .font(Theme.Fonts.title)
                    .foregroundStyle(Theme.Colors.textPrimary)

                Text("Scan in Home or enter barcode manually.")
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Theme.Spacing.s20)

                TextField("Enter barcode manually", text: $manualBarcode)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                    .padding(Theme.Spacing.s12)
                    .background(Theme.Colors.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.r12)
                            .stroke(Theme.Colors.border, lineWidth: 1)
                    )
                    .clipShape(.rect(cornerRadius: Theme.Radius.r12))
                    .padding(.horizontal, Theme.Spacing.s20)

                HStack(spacing: Theme.Spacing.s12) {
                    Button("Submit") {
                        onSubmitManualBarcode(manualBarcode)
                    }
                    .primaryButtonStyle(height: 46)
                }
                .padding(.horizontal, Theme.Spacing.s20)

                Button("Skip barcode → Capture images", action: onSkipToCamera)
                    .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            .padding(.top, Theme.Spacing.s32)
        }
    }
}
