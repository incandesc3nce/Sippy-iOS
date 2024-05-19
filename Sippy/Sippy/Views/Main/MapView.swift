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
    var category: String
    var latitude: Double
    var longitude: Double
    
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func getLatitude() -> Double {
        return location?.coordinate.longitude ?? 83.7698
    }
    
    func getLongitude() -> Double {
        return location?.coordinate.latitude ?? 53.3600
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}



// token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.FmlgL5f2FlT2ty8hRdQgxmJD6vG2gspgbTHLS_ecZTY
// ios_test
// testtest

var mapLocations = [Location]()

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    let nearestService = APINearestService()
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    
    @State private var initialPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.3600, longitude: 83.7698),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    
    @State private var selectedPlace: Location?
    @State private var tempLocation: Location?

    @State private var isCreatingPlace = false
    @State private var editingPlace: Location?

    @State private var showAlert = false

    @State private var locations = [Location]()
    
    var body: some View {
        ZStack {
            MapReader { proxy in
                Map(
                    initialPosition: initialPosition
                ) {
                    ForEach(locations) { location in
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: location.longitude, longitude: location.latitude)) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 54)
                                .onLongPressGesture(minimumDuration: 0.01) {
                                    selectedPlace = location
                                }
                        }
                    }
                    if let tempLocation = tempLocation {
                        Annotation(tempLocation.name, coordinate: CLLocationCoordinate2D(latitude: tempLocation.latitude, longitude: tempLocation.longitude)) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 54)
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        
                        tempLocation = Location(id: UUID(), name: "", description: "", category: "pubs", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        isCreatingPlace = true
                    }
                }
                .sheet(item: $selectedPlace) { place in
                    PointView(location: place, tempLocation: $tempLocation)
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
                                .background(.white)
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
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    })
                    .background(Color.orange)
                    .cornerRadius(10.0)
                }
                Spacer()
            }
            
            .sheet(item: $editingPlace) { place in
                EditView(location: place, tempLocation: $tempLocation) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                    
                    tempLocation = nil
                }
            }
            .onChange(of: mapLocations) {
                locations = mapLocations
            }
            
        }
        
    }
        
}

#Preview {
    MapView()
}
