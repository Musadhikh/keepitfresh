//
//  HomeView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        List {
            Section("Quick Actions") {
                Button {
                    appState.navigate(to: .appInfo)
                } label: {
                    Label("Open App Info", systemImage: Theme.Icon.appInfo.systemName)
                }
                
                Button {
                    appState.setNavigation(tab: .profile, routes: [.profileDetails])
                } label: {
                    Label("Open Profile Details", systemImage: Theme.Icon.profileDetails.systemName)
                }
                
                Button {
                    appState.navigate(to: .householdSelection)
                } label: {
                    Label("Select Household", systemImage: Theme.Icon.householdSelection.systemName)
                }
            }
            
            Section("Deep Link Examples") {
                Text("keepitfresh://profile")
                Text("keepitfresh://profile/details")
                Text("keepitfresh://app-info")
                Text("keepitfresh://households/select")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        .navigationTitle("Home")
    }
}

#if DEBUG
#Preview {
    HomeView()
        .environment(AppState())
}
#endif
