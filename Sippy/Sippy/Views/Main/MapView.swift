//
//  MapView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}





struct MapView: View {
    
    @State private var userLocation = CLLocationCoordinate2D()
    
    @State private var initialPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.3600, longitude: 83.7698),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    @State private var tempLocation: Location?

    @State private var isCreatingPlace = false
    @State private var editingPlace: Location?

    @State private var showAlert = false
    
    
    var body: some View {
        ZStack {
            
            MapReader { proxy in
                Map(
                    initialPosition: initialPosition
                ) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 54)
                                .onLongPressGesture {
                                    selectedPlace = location
                                }
                        }
                    }
                    if let tempLocation = tempLocation {
                        Annotation(tempLocation.name, coordinate: tempLocation.coordinate) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 54)
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                    
                        tempLocation = Location(id: UUID(), name: "", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        isCreatingPlace = true
                    }
                }
                .sheet(item: $selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        if let index = locations.firstIndex(of: place) {
                            locations[index] = newLocation
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    if isCreatingPlace {
                        Button(action: {
                            tempLocation = nil
                            isCreatingPlace = false
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(.orange)
                                .background(.black)
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        })
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                // just to align slightly higher than tab bar
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                
                if isCreatingPlace {
                    Button(action: {
                        if let tempLocation = tempLocation {
                            locations.append(tempLocation)
                            editingPlace = tempLocation
                        }
                        isCreatingPlace = false
                    }, label: {
                        Text("Создать точку")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding()
                    })
                    .background(Color.orange)
                    .cornerRadius(10.0)
                }
                Spacer()
            }
            
            .sheet(item: $editingPlace) { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                    
                    tempLocation = nil
                }
            }
            
        }
    }
}

#Preview {
    MapView()
}
