//
//  Theme.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines the Liquid Glass design-system tokens for color, typography, spacing, radius, and elevation.
//

import SwiftUI

public enum Theme {
    public enum Colors {
        // Core semantic tokens from the Liquid Glass design system.
        public static let accent = Color(dynamicLight: "#3CB371", dark: "#52C884")
        public static let accentSoft = Color(dynamicLight: "#E8F7EE", dark: "#1E382A")
        public static let background = Color(dynamicLight: "#F6F8F7", dark: "#111412")
        public static let border = Color(dynamicLight: "#D7E2DC", dark: "#34423B")
        public static let danger = Color(dynamicLight: "#DF5A57", dark: "#E57A76")
        public static let success = Color(dynamicLight: "#3CB371", dark: "#52C884")
        public static let warning = Color(dynamicLight: "#EFB849", dark: "#F2C86A")
        public static let surface = Color(dynamicLight: "#FFFFFF", dark: "#1A1F1C")
        public static let surfaceAlt = Color(dynamicLight: "#EFF5F1", dark: "#242B27")
        public static let textPrimary = Color(dynamicLight: "#17201B", dark: "#F1F5F2")
        public static let textSecondary = Color(dynamicLight: "#5E6E65", dark: "#A6B6AD")

        // Liquid palette aliases used in Stitch boards.
        public static let primary = accent
        public static let deep = success
        public static let mint = accentSoft
        public static let honeydew = surfaceAlt
        public static let pure = surface

        // Interaction and surface state colors.
        public static let textOnAccent = Color(dynamicLight: "#FFFFFF", dark: "#0F1D15")
        public static let glassBorder = border
        public static let glassHighlight = accent.opacity(0.15)
        public static let successSoft = success.opacity(0.16)
        public static let warningSoft = warning.opacity(0.16)
        public static let dangerSoft = danger.opacity(0.16)

        // Existing aliases kept for compatibility with older screens.
        public static let primary10 = accent.opacity(0.10)
        public static let primary20 = accent.opacity(0.20)
        public static let primary30 = accent.opacity(0.30)
        public static let primary40 = accent.opacity(0.40)
        public static let primary60 = accent.opacity(0.60)
        public static let white05 = Color.white.opacity(0.05)
        public static let white10 = Color.white.opacity(0.10)
        public static let white15 = Color.white.opacity(0.15)
        public static let white20 = Color.white.opacity(0.20)
        public static let borderThin = Color.white.opacity(0.10)
        public static let borderRegular = Color.white.opacity(0.15)

        public static let splashGradientStart = accent
        public static let splashGradientMid = accentSoft
        public static let splashGradientEnd = surfaceAlt
    }

    public enum Fonts {
        private static let displayName = "SF Pro Display"
        private static let bodyName = "SF Pro Text"

        public static func display(
            _ size: CGFloat,
            weight: Font.Weight = .regular,
            relativeTo textStyle: Font.TextStyle = .body
        ) -> Font {
            if UIFont(name: displayName, size: size) != nil {
                return Font.custom(displayName, size: size, relativeTo: textStyle).weight(weight)
            }
            return Font.system(textStyle, design: .rounded).weight(weight)
        }

        public static func body(
            _ size: CGFloat,
            weight: Font.Weight = .regular,
            relativeTo textStyle: Font.TextStyle = .body
        ) -> Font {
            if UIFont(name: bodyName, size: size) != nil {
                return Font.custom(bodyName, size: size, relativeTo: textStyle).weight(weight)
            }
            return Font.system(textStyle, design: .default).weight(weight)
        }

        public static var titleLarge: Font { display(28, weight: .semibold, relativeTo: .largeTitle) }
        public static var title: Font { display(22, weight: .semibold, relativeTo: .title2) }
        public static var bodyRegular: Font { body(16, weight: .regular, relativeTo: .body) }
        public static var bodyMedium: Font { body(16, weight: .medium, relativeTo: .body) }
        public static var caption: Font { body(12, weight: .medium, relativeTo: .caption) }

        // Liquid Glass typography aliases.
        public static var displayBold: Font { display(28, weight: .bold, relativeTo: .largeTitle) }
        public static var headingLarge: Font { display(22, weight: .semibold, relativeTo: .title2) }
        public static var base: Font { bodyRegular }
    }

    public enum Icon: String, CaseIterable {
        // Tabs and navigation
        case homeTab = "house"
        case profileTab = "person"
        case appInfo = "info.circle"
        case profileDetails = "person.text.rectangle"
        case householdSelection = "house.and.flag"
        case cameraScanner = "camera.viewfinder"
        case analyserResult = "sparkles.rectangle.stack"
        case houseCreate = "plus"
        case houseSelected = "checkmark.circle.fill"
        case houseUnselected = "circle"

        // Branding
        case splashLeaf = "leaf"
        case splashBox = "shippingbox"
        case loginBrand = "leaf.circle.fill"

        // States and alerts
        case maintenance = "wrench.and.screwdriver"
        case warning = "exclamationmark.triangle.fill"
        case profileUnavailable = "person.crop.circle.badge.xmark"

        // Profile actions
        case logout = "rectangle.portrait.and.arrow.right"
        case delete = "trash"

        case locationPin = "mappin.and.ellipse"

        // Product overview
        case productBack = "chevron.left"
        case productMore = "ellipsis"
        case productGenerating = "arrow.triangle.2.circlepath"
        case productBarcode = "barcode"
        case productDates = "calendar"
        case productCategory = "square.grid.2x2"
        case productDetails = "shippingbox.fill"
        case lock = "lock.fill"

        // Liquid Glass navigation and quick actions
        case kitchen = "fork.knife"
        case basket = "basket.fill"
        case stock = "archivebox.fill"
        case config = "gearshape.fill"
        case scanTab = "barcode.viewfinder"
        case notifications = "bell.fill"
        
        public var systemName: String { rawValue }
    }

    public enum Radius {
        public static let r12: CGFloat = 12
        public static let r16: CGFloat = 16
        public static let r20: CGFloat = 20
        public static let r24: CGFloat = 24
        public static let pill: CGFloat = 999

        // Liquid Glass aliases.
        public static let glassCard = r24
        public static let glassControl = r16
        public static let glassPill = pill
    }

    public enum Spacing {
        public static let s4: CGFloat = 4
        public static let s8: CGFloat = 8
        public static let s12: CGFloat = 12
        public static let s16: CGFloat = 16
        public static let s20: CGFloat = 20
        public static let s24: CGFloat = 24
        public static let s28: CGFloat = 28
        public static let s32: CGFloat = 32

        // Liquid Glass aliases.
        public static let section = s24
        public static let component = s16
        public static let micro = s8
    }

    public enum Elevation {
        public static let glassShadowColor = Colors.accent.opacity(0.18)
        public static let glassShadowRadius: CGFloat = Theme.Spacing.s8
        public static let glassShadowYOffset: CGFloat = Theme.Spacing.s4
    }

    public enum Border {
        public static let hairline: CGFloat = 1
        public static let regular: CGFloat = 1
    }
}

private extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self = Color(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    init(dynamicLight lightHex: String, dark darkHex: String) {
        #if os(iOS) || os(tvOS) || os(visionOS)
        self = Color(UIColor { trait in
            let isDark = trait.userInterfaceStyle == .dark
            return UIColor(hex: isDark ? darkHex : lightHex)
        })
        #elseif os(macOS)
        self = Color(NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            return NSColor(hex: isDark ? darkHex : lightHex)
        })
        #else
        self = Color(hex: lightHex)
        #endif
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
private extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
#endif

#if os(macOS)
import AppKit
private extension NSColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            srgbRed: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
#endif
