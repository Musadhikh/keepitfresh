//
//
//  ProductAIView.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ProductOverView
//
    

import SwiftUI
import CameraModule

struct ProductOverView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: ProductAIViewModel
    
    var body: some View {
        VStack(spacing: Theme.Spacing.s24) {
            Image(icon: .analyserResult)
                .font(.largeTitle)
                .foregroundStyle(Theme.Colors.accent)
            
            ProgressView("Analyzing images...")
                .font(Theme.Fonts.bodyRegular)
                .controlSize(.large)
            
            Text("\(viewModel.imageCount) images captured")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            if let product = viewModel.product {
                if let title = product.title {
                    Text("Product: \(title)")
                        .font(Theme.Fonts.bodyRegular)
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
            } else {
                Text("Preparing scan insights. This is a placeholder result screen.")
                    .font(Theme.Fonts.bodyRegular)
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
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
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    ProductOverView(viewModel: ProductAIViewModel(capturedImages: []))
}
