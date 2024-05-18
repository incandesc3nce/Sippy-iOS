//
//  MainView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var locationManager = LocationManager()
    let nearestService = APINearestService()
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    
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
        .onAppear(perform: {
            locationManager.requestLocationAuthorization()
            
        })
        
        .onChange(of: locationManager.authorizationStatus) { status in
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                if let location = locationManager.location {
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                    nearestService.getNearest(latitude: String(latitude), longitude: String(longitude)) { result in
                        nearLocations = transformNearest(pointsAround)
                        locations = nearLocations
                    }
                }
            }
        }
        .onChange(of: nearLocations) { newValue in
            if let lastLocation = newValue.last {
                locations.append(lastLocation)
            }
        }
        
        
        
    }
}

#Preview {
    MainView()
}
