//
//
//  RoundedVerticalButton.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: RoundedVerticalButton
//
    
import SwiftUI

struct RoundedVerticalButton: View {
    let title: String
    let icon: Theme.Icon
    let accessibilityLabel: String
    let action: () -> Void
    
    private let imageSize: CGFloat = 44
    
    var body: some View {
        Button(
            action: action,
            label: {
                VStack {
                    Image(icon: icon)
                        .font(.system(size: 18, weight: .thin))
                        .foregroundStyle(Theme.Colors.accent)
                        .frame(width: imageSize, height: imageSize)
                        .glassEffect()
                        .clipShape(.circle)
                    
                    Text(title)
                        .font(Theme.Fonts.body(14, weight: .light, relativeTo: .caption))
                        .foregroundStyle(.white)
                }
            }
        )
        .buttonStyle(.plain)
        .accessibilityLabel(Text(accessibilityLabel))
    }
}
