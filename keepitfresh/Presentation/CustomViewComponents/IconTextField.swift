//
//
//  IconTextField.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: IconTextField is a reusable SwiftUI component that combines a text field with an icon, designed for consistent styling across the app. It accepts a title, an icon, a placeholder, and a binding to the text input, making it flexible for various use cases such as login forms or search bars. The component is styled with the app's theme, ensuring visual coherence throughout the user interface.
//

import SwiftUI

struct IconTextField: View {
    var title: String? = nil
    let icon: Theme.Icon
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            if let title {
                Text(title)
                    .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .body))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            TextField(placeholder, text: $text)
                .safeAreaInset(edge: .leading) {
                    Image(icon: icon)
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                .font(Theme.Fonts.bodyRegular)
                .foregroundStyle(Theme.Colors.textPrimary)
                .padding(.horizontal, Theme.Spacing.s12)
                .frame(height: 50)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r16))
                .overlay {
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                }
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
        }
    }
}
