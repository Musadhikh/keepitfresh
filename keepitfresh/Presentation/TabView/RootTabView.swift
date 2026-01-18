//
//  RootTabView.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 16/1/26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#if DEBUG
#Preview {
    RootTabView()
}
#endif
