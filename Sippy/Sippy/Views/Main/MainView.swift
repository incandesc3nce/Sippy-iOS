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
                Label("Карта", systemImage: "map")
            }
            
            
            
            ProfileView()
            .tabItem {
                Label("Профиль", systemImage: "person.fill")
            }
            
            
        }
        
        
    }
}

#Preview {
    MainView()
}
