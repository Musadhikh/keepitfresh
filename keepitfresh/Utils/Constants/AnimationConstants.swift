//
//  AnimationConstants.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

/// Animation constants used throughout the app
enum AnimationConstants {
    // MARK: - Splash Animations
    static let splashIconSpring = Animation.spring(response: 0.8, dampingFraction: 0.6)
    static let splashTextEaseOut = Animation.easeOut(duration: 0.6)
    static let splashProgressEaseIn = Animation.easeIn(duration: 0.3)
    
    // MARK: - Timing
    static let splashIconDelay: TimeInterval = 0.0
    static let splashTextDelay: TimeInterval = 0.3
    static let splashSubtextDelay: TimeInterval = 0.5
    static let splashProgressDelay: TimeInterval = 1.0
    static let splashProgressTextDelay: TimeInterval = 1.2
    
    // MARK: - Transitions
    static let sceneTransition = Animation.easeInOut(duration: 0.5)
}
