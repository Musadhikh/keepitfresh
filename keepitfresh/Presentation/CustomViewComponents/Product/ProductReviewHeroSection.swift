//
//
//  ProductReviewHeroSection.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewHeroSection
//
    
import SwiftUI

struct ProductReviewHeroSection: View {
    let images: [UIImage]
    @Binding var selectedImageIndex: Int
    let title: String
    let subtitle: String
    let summary: String
    @Binding var itemCount: Int

    private var pageCount: Int {
        max(images.count, 1)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedImageIndex) {
                if images.isEmpty {
                    ZStack {
                        Theme.Colors.surfaceAlt
                        Image(icon: .analyserResult)
                            .font(Theme.Fonts.display(36, weight: .semibold, relativeTo: .title))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .tag(0)
                } else {
                    ForEach(images.enumerated(), id: \.offset) { index, image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 240)
            .clipShape(.rect(cornerRadius: Theme.Radius.r20))

            HStack(spacing: Theme.Spacing.s8) {
                ForEach(0 ..< pageCount, id: \.self) { index in
                    Circle()
                        .fill(index == selectedImageIndex ? Theme.Colors.accent : Theme.Colors.border)
                        .frame(width: Theme.Spacing.s8, height: Theme.Spacing.s8)
                }
            }
            .padding(.bottom, Theme.Spacing.s8)

            ProductReviewCard {
                VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                    Text(title)
                        .font(Theme.Fonts.body(24, weight: .semibold, relativeTo: .title2))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .lineLimit(2)

                    Text(subtitle)
                        .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .subheadline))
                        .foregroundStyle(Theme.Colors.accent)

                    Text(summary)
                        .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .lineLimit(3)

                    ProductReviewCounterRow(itemCount: $itemCount)
                }
            }
            .padding(.horizontal, Theme.Spacing.s12)
            .offset(y: Theme.Spacing.s20)
        }
        .padding(.bottom, Theme.Spacing.s20)
    }
}
