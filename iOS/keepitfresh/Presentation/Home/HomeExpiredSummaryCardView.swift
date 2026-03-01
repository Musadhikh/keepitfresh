//
//  HomeExpiredSummaryCardView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Highlights the expired inventory count at the top of Home.
//

import SwiftUI

struct HomeExpiredSummaryCardView: View {
    let expiredCount: Int

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.s12) {
            Image(icon: .warning)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Theme.Colors.danger)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r12))

            VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                Text("Expired Items")
                    .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    .foregroundStyle(Theme.Colors.textPrimary)

                Text("You have \(expiredCount) expired items that need attention.")
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
        .padding(Theme.Spacing.s16)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r20))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r20)
                .stroke(Theme.Colors.danger.opacity(0.22), lineWidth: 1)
        )
    }
}
