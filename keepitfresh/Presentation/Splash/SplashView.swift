//
//  SplashView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(AppState.self) var appState
    
    @State private var viewModel = SplashViewModel()
    @State private var animateIcon = false
    @State private var animateText = false
    @State private var showProgress = false
    
    let onComplete: () -> Void
    
    init(onComplete: @escaping () -> Void = {}) {
        self.onComplete = onComplete
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    .splashGradientStart,
                    .splashGradientMid,
                    .splashGradientEnd
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                // App icon
                VStack(spacing: 16) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 80, weight: .light))
                        .foregroundStyle(.white)
                        .scaleEffect(animateIcon ? 1.0 : 0.5)
                        .opacity(animateIcon ? 1.0 : 0.0)
                        .animation(
                            AnimationConstants.splashIconSpring,
                            value: animateIcon
                        )
                    
                    // App name
                    VStack(spacing: 4) {
                        Text("Keep It Fresh")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(animateText ? 1.0 : 0.0)
                            .offset(y: animateText ? 0 : 20)
                            .animation(
                                AnimationConstants.splashTextEaseOut.delay(AnimationConstants.splashTextDelay),
                                value: animateText
                            )
                        
                        Text("Track your food, save your money")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                            .opacity(animateText ? 1.0 : 0.0)
                            .offset(y: animateText ? 0 : 20)
                            .animation(
                                AnimationConstants.splashTextEaseOut.delay(AnimationConstants.splashSubtextDelay),
                                value: animateText
                            )
                    }
                }
                
                Spacer()
                
                // Loading indicator
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .opacity(showProgress ? 1.0 : 0.0)
                        .animation(
                            AnimationConstants.splashProgressEaseIn.delay(AnimationConstants.splashProgressDelay),
                            value: showProgress
                        )
                    
                    Text("Loading...")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                        .opacity(showProgress ? 1.0 : 0.0)
                        .animation(
                            AnimationConstants.splashProgressEaseIn.delay(AnimationConstants.splashProgressTextDelay),
                            value: showProgress
                        )
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            startAnimations()
        }
        .onChange(of: viewModel.shouldNavigate) { _, shouldNavigate in
            if shouldNavigate {
                onComplete()
                appState.enterMain()
            }
        }
        .accessibilityLabel("Keep It Fresh app loading screen")
    }
    
    private func startAnimations() {
        // Start icon animation immediately
        animateIcon = true
        
        // Start text animation after icon
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationConstants.splashTextDelay) {
            animateText = true
        }
        
        // Show progress indicator after text
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationConstants.splashProgressDelay) {
            showProgress = true
        }
    }
}

#Preview {
    #if DEBUG
    SplashView(onComplete: {
        print("Splash completed")
    })
    #endif
}
