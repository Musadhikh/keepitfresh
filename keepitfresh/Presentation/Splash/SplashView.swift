//
//  SplashView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 7/9/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(AppState.self) var appState
    
    @State private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                Color.clear
                    .frame(height: Theme.Spacing.s20)
                
                SplashHeroSection()
                .frame(maxHeight: .infinity)
                
                Text("Powered by KeepItFresh")
                    .font(Theme.Fonts.caption)
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            .padding(.top, 28)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .task {
            await viewModel.start()
        }
        .onChange(of: viewModel.launchState) { _, newState in
            guard let newState else { return }
            handleLaunchState(newState)
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
        .accessibilityLabel("Keep It Fresh app loading screen")
    }
    
    private func handleLaunchState(_ state: AppLaunchState) {
        switch state {
        case .maintenance:
            appState.enterMaintenance()
        case .updateRequired, .createHousehold, .selectHousehold:
            appState.enterMain()
        case .loginRequired:
            appState.requireAuthentication()
        case .mainContent:
            appState.enterMain()
        }
    }
}

private struct SplashHeroSection: View {
    var body: some View {
        VStack(spacing: Theme.Spacing.s16) {
            SplashLogoBadge()
            
            Text("Track it. Scan it. Save it.")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text("Smarter home inventory for busy households")
                .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct SplashLogoBadge: View {
    @ScaledMetric(relativeTo: .title2) private var badgeSize: CGFloat = 182
    @ScaledMetric(relativeTo: .title2) private var iconSize: CGFloat = 64
    
    var body: some View {
        VStack(spacing: Theme.Spacing.s16) {
            Image(icon: .splashLeaf)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(Theme.Colors.accent)
            
            Text("Keep It Fresh")
                .font(Theme.Fonts.body(21, weight: .bold, relativeTo: .title3))
                .foregroundStyle(Theme.Colors.textPrimary)
        }
        .frame(width: badgeSize, height: badgeSize)
        .background(Theme.Colors.surface)
        .overlay {
            RoundedRectangle(cornerRadius: 34)
                .stroke(Theme.Colors.border, lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: 34))
    }
}

#if DEBUG
#Preview {
    SplashView(viewModel: .preview)
        .environment(AppState())
}
#endif
