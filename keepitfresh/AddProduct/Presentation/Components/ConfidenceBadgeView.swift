//
//  ConfidenceBadgeView.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Subtle confidence indicator for AI-filled draft fields.
//

import SwiftUI

struct ConfidenceBadgeView: View {
    let confidence: Double?

    private var normalized: Double {
        min(max(confidence ?? 0.0, 0.0), 1.0)
    }

    private var label: String {
        "\(Int((normalized * 100).rounded()))%"
    }

    var body: some View {
        if confidence != nil {
            Text(label)
                .font(Theme.Fonts.body(11, weight: .semibold, relativeTo: .caption2))
                .foregroundStyle(Theme.Colors.textSecondary)
                .padding(.horizontal, Theme.Spacing.s8)
                .padding(.vertical, Theme.Spacing.s4)
                .background(Theme.Colors.surfaceAlt)
                .clipShape(.rect(cornerRadius: Theme.Radius.pill))
        }
    }
}
