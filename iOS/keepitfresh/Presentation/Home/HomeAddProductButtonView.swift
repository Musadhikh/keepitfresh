//
//  HomeAddProductButtonView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Floating add product action used on the Home screen.
//

import SwiftUI

struct HomeAddProductButtonView: View {
    let onTap: () -> Void

    private let imageSize: CGFloat = 60
    var body: some View {
        
        
        Button(action: onTap) {
            Image(icon: .houseCreate)
                .font(.system(size: 35, weight: .semibold))
                .frame(width: imageSize, height: imageSize)
        }
        .buttonStyle(.plain)
        .background(Theme.Colors.accent.opacity(0.8))
        .foregroundStyle(Theme.Colors.surface)
        
        .clipShape(.circle)
        .glassEffect(.clear)
        .accessibilityIdentifier("home.addProductButton")
    }
}

#if DEBUG
#Preview {
    ZStack(alignment: .bottomTrailing) {
        Color.yellow.ignoresSafeArea()
    }
    .safeAreaInset(edge: .bottom, alignment: .trailing) {
        HomeAddProductButtonView(onTap: {})
            .padding(.trailing, 20)
    }
}
#endif
