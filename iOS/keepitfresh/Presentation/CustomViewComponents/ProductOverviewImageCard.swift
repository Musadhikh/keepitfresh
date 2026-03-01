//
//
//  ProductOverviewImageCard.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: ProductOverviewImageCard
//
    
import SwiftUI
import UIKit

struct ProductOverviewImageCard: View {
    let images: [UIImage]
    @Binding var selectedImageIndex: Int

    private var pageCount: Int {
        max(images.count, 1)
    }

    var body: some View {
        VStack(spacing: Theme.Spacing.s8) {
            TabView(selection: $selectedImageIndex) {
                if images.isEmpty {
                    ProductOverviewImagePlaceholder()
                        .tag(0)
                } else {
                    ForEach(images.indices, id: \.self) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 190)
                            .clipShape(.rect(cornerRadius: Theme.Radius.r20))
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 190)

            HStack(spacing: Theme.Spacing.s8) {
                ForEach(0 ..< pageCount, id: \.self) { index in
                    Circle()
                        .fill(index == selectedImageIndex ? Theme.Colors.accent : Theme.Colors.border)
                        .frame(width: Theme.Spacing.s8, height: Theme.Spacing.s8)
                }
            }
        }
        .padding(Theme.Spacing.s12)
        .background(Theme.Colors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r24)
                .stroke(Theme.Colors.border, lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: Theme.Radius.r24))
    }
}

private struct ProductOverviewImagePlaceholder: View {
    var body: some View {
        ZStack {
            Theme.Colors.surfaceAlt
            Image(icon: .analyserResult)
                .font(Theme.Fonts.display(34, weight: .semibold, relativeTo: .largeTitle))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .frame(height: 190)
        .clipShape(.rect(cornerRadius: Theme.Radius.r20))
    }
}
