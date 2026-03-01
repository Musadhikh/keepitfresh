//
//  MaintenanceView.swift
//  keepitfresh
//
//  Created by Assistant on 11/12/25.
//  Summary: Presents a design-system aligned maintenance fallback screen.
//

import SwiftUI

struct MaintenanceView: View {
    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()

            VStack(spacing: Theme.Spacing.s16) {
                Image(icon: .maintenance)
                    .font(Theme.Fonts.display(Theme.Spacing.s32 * 2, relativeTo: .largeTitle))
                    .foregroundStyle(Theme.Colors.textSecondary)
                
                Text("We’ll be right back")
                    .font(Theme.Fonts.title)
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("Keep It Fresh is undergoing scheduled maintenance. Please check back soon.")
                    .font(Theme.Fonts.bodyRegular)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .padding(.horizontal, Theme.Spacing.s24)
            }
            .padding(Theme.Spacing.s24)
        }
        .accessibilityLabel("App is under maintenance")
    }
}

#if DEBUG
#Preview {
    MaintenanceView()
}
#endif
