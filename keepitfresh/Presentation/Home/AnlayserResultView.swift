//
//  AnlayserResultView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Shows a temporary analyser loading screen and the count of captured camera images.
//

import SwiftUI
import CameraModule

struct AnlayserResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    let capturedImages: [CameraCapturedImage]
    
    var body: some View {
        VStack(spacing: Theme.Spacing.s24) {
            Image(icon: .analyserResult)
                .font(.largeTitle)
                .foregroundStyle(Theme.Colors.accent)
            
            ProgressView("Analyzing images...")
                .font(Theme.Fonts.bodyRegular)
                .controlSize(.large)
            
            Text("\(capturedImages.count) images captured")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Preparing scan insights. This is a placeholder result screen.")
                .font(Theme.Fonts.bodyRegular)
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Theme.Spacing.s24)
        .background(Theme.Colors.background)
        .navigationTitle("Analyser Result")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        AnlayserResultView(capturedImages: [])
    }
}
#endif
