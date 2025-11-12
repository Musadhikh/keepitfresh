//
//  MaintenanceView.swift
//  keepitfresh
//
//  Created by Assistant on 11/12/25.
//

import SwiftUI

struct MaintenanceView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 64, weight: .regular))
                    .foregroundStyle(.secondary)
                
                Text("We’ll be right back")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text("Keep It Fresh is undergoing scheduled maintenance. Please check back soon.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 24)
            }
            .padding()
        }
        .accessibilityLabel("App is under maintenance")
    }
}

#if DEBUG
#Preview {
    MaintenanceView()
}
#endif

