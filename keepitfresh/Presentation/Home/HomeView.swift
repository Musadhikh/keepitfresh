//
//  HomeView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import SwiftUI
import CameraModule

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State var showCamera = false
    
    var body: some View {
        List {
            Section("Quick Actions") {
                Button {
//                    appState.navigate(to: .appInfo)
                    showCamera.toggle()
                } label: {
                    Label("Scan", systemImage: Theme.Icon.appInfo.systemName)
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
        .fullScreenCover(isPresented: $showCamera) {
            CameraScannerView { result in
                
            }
        }
    }
}

#if DEBUG
#Preview {
    HomeView()
        .environment(AppState())
}
#endif
