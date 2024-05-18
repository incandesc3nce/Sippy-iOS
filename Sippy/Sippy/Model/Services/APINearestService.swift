import Foundation

struct NearestPoint: Codable {
    let id: Int
    let chunk_id: Int
    let user_id: Int
    let is_house: Bool
    let created_at: String
    let updated_at: String
    let longitude: String
    let latitude: String
}

class APINearestService {
    var decodedAnswer: String = ""
    
    func getNearest(latitude: String, longitude: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://79.174.80.34:8081/api/point/nearest/")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authentication")
        
        let parameters: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude
        ]
        print(parameters)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(NSError(domain: "JSON Encoding Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode parameters: \(error.localizedDescription)"])))
            return
        }
        
        // Create a URLSession data task to send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure we have a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
                return
            }
            
            // Check the status code
            if httpResponse.statusCode == 200 {
                // Handle valid response
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let nearestPoints = try decoder.decode([NearestPoint].self, from: data)
                        pointsAround = nearestPoints
                        print("good!")
                    } catch {
                        completion(.failure(NSError(domain: "Decoding Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response data: \(error.localizedDescription)"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "Data Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response data."])))
                }
            } else {
                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to get nearest point. Status code: \(httpResponse.statusCode)"])))
            }
        }
        
        // Start the task
        task.resume()
    }
}
