//
//  APIPointService.swift
//  Sippy
//
//  Created by Dmitry on 18.05.2024.
//

import Foundation

struct pointParameters {
    var latitude: String
    var longitude: String
    var is_house: String
}

class APIPointService {
    
    func sendLocation(_ location: Location) {
        let urlString = "http://79.174.80.34:8081/api/point/"
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let value = "Bearer \(userToken)"
        // change later lol
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(value, forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "latitude": String(location.latitude),
            "longitude": String(location.longitude),
            "is_house": String(location.typeOfEvent)
        ]
        
        print(parameters)
        // Encode the Location object to JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to encode location: \(error.localizedDescription)")
            return
        }
        
        // Create a URLSession data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                print("Error sending request: \(error.localizedDescription)")
                return
            }
            
            // Ensure we have a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }
            
            // Check the status code
            if httpResponse.statusCode == 200 {
                print("Point was saved correctly.")
            } else {
                print("Failed to save point. Status code: \(httpResponse.statusCode) \n \(httpResponse)")
            }
        }
        
        // Start the task
        task.resume()
    }
}

