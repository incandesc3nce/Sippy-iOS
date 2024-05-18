//
//  TransformNearest.swift
//  Sippy
//
//  Created by Dmitry on 19.05.2024.
//

import Foundation

func transformNearest(_ nearestPoints: [NearestPoint]) -> [Location] {
    var locations = [Location]()
    
    for point in nearestPoints {
        var newLocation = Location(id: UUID(), name: "", description: "", typeOfEvent: 0, latitude: Double(point.latitude)!, longitude: Double(point.longitude)!)
        
        locations.append(newLocation)
    }
    
    return locations
}
