//
//  MainView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MapView()
            .tabItem {
                Label("Map", systemImage: "map")
            }
            
            
            
            ProfileView()
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        
        
    }
}

#Preview {
    MainView()
}
