//
//
//  ButtonStyles.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: ButtonStyles defines a custom button style for the app's primary buttons, ensuring a consistent look and feel across the app. The style includes properties for height, font, foreground color, background color, and corner radius. An extension on View allows for easy application of this style to any button within the app.
//
    

import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    struct Constants {
        static let buttonHeight: CGFloat = 48
    }
    @Environment(\.isEnabled) private var isEnabled: Bool
    var height: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: height ?? Constants.buttonHeight)
            .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .body))
            .foregroundStyle(.white)
            .background(Theme.Colors.accent.opacity(isEnabled ? 1 : 0.3))
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}

struct SecondaryButtonStyle: ViewModifier {
    struct Constants {
        static let buttonHeight: CGFloat = 48
    }
    
    var height: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: height ?? Constants.buttonHeight)
            .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .body))
            .foregroundStyle(Theme.Colors.textPrimary)
            .background(Theme.Colors.accentSoft)
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}



extension View {
    func primaryButtonStyle(height: CGFloat? = nil) -> some View {
        modifier(PrimaryButtonStyle(height: height))
    }
    
    func secondaryButtonStyle(height: CGFloat? = nil) -> some View {
        modifier(SecondaryButtonStyle(height: height))
    }
}
