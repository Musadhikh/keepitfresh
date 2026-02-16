//
//  HomeView.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Displays home actions and presents camera scanning plus analyser result flows.
//

import SwiftUI
import CameraModule

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var isCameraPresented = false
    @State private var shouldPresentAnalyserResult = false
    @State private var isAnalyserPresented = false
    @State private var capturedImages: [CameraCapturedImage] = []
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section("Quick Actions") {
                    Button {
                        appState.navigate(to: .appInfo)
                    } label: {
                        Label("App Info", systemImage: Theme.Icon.appInfo.systemName)
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
            
            Button {
                isCameraPresented = true
            } label: {
                Label {
                    Text("Scan")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                } icon: {
                    Image(icon: .cameraScanner)
                        
                }
            }
            .foregroundStyle(Theme.Colors.surface)
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.accent)
            .clipShape(.rect(cornerRadius: Theme.Radius.pill))
            .shadow(color: Theme.Colors.primary30, radius: Theme.Spacing.s8, y: Theme.Spacing.s4)
            .padding(.trailing, Theme.Spacing.s20)
            .padding(.bottom, Theme.Spacing.s20)
        }
        .onChange(of: capturedImages) {
            shouldPresentAnalyserResult = true
        }
        .fullScreenCover(isPresented: $isCameraPresented, onDismiss: {
            if shouldPresentAnalyserResult {
                shouldPresentAnalyserResult = false
                isAnalyserPresented = true
            }
        }) {
            CameraScannerView(
                onCancel: { isCameraPresented = false },
                onComplete: { result in
                    if result.isEmpty { return }
                    capturedImages = result
                    isCameraPresented = false
                }
            )
        }
        .fullScreenCover(isPresented: $shouldPresentAnalyserResult) {
            NavigationStack {
                ProductOverView(viewModel: ProductOverViewModel(capturedImages: capturedImages))
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
