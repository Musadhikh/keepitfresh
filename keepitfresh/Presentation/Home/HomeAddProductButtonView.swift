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

    var body: some View {
        Button(action: onTap) {
            Label {
                Text("Add Product")
                    .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
            } icon: {
                Image(icon: .addFilled)
            }
            .foregroundStyle(Theme.Colors.surface)
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
        }
        .buttonStyle(.plain)
        .background(Theme.Colors.accent)
        .clipShape(.rect(cornerRadius: Theme.Radius.pill))
        .shadow(color: Theme.Colors.primary30, radius: 2, y: 1)
        .padding(.bottom, Theme.Spacing.s20)
    }
}
