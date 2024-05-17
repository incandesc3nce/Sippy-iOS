//
//  APIService.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import Foundation

class APIServiceRegister: ObservableObject {
    var decodedAnswer: String = ""
    
    func register(name: String, email: String, password: String, gender: Int, age: Int?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://79.174.80.34:8081/api/registration") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var parameters: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "gender": gender,
            "age": age!
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure the response is an HTTP response.
            guard let httpResponse = response as? HTTPURLResponse else {
                let invalidResponseError = NSError(domain: "Invalid response", code: -1, userInfo: nil)
                completion(.failure(invalidResponseError))
                return
            }
            
            // Check the status code and call it a success if it's 200.
            if httpResponse.statusCode == 200 {
                completion(.success("true"))
            } else {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseString)")
                }
                
                let statusCodeError = NSError(domain: "Invalid response", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(statusCodeError))
            }
        }

        task.resume()
        
    }
    
    
}



import Foundation

// Define a struct for the login response.
struct LoginResponse: Codable {
    let success: Bool
    let token: String?
    let message: String?
}

class APIServiceLogin {
    var userToken: String = ""
    
    // The login function takes name and password, sends a POST request, and returns the decoded response.
    func login(name: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        // Ensure the URL is valid.
        guard let url = URL(string: "http://79.174.80.34:8081/api/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Create the request.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create the JSON payload.
        let loginData = ["name": name, "password": password]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // Create the data task.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors from the network or URLSession.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            
            // Ensure the response is an HTTP response.
            guard let httpResponse = response as? HTTPURLResponse else {
                let invalidResponseError = NSError(domain: "Invalid response", code: -1, userInfo: nil)
                completion(.failure(invalidResponseError))
                return
            }
            
            // Check the status code and print it if it's not 200.
            guard httpResponse.statusCode == 200 else {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                let statusCodeError = NSError(domain: "Invalid response", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(statusCodeError))
                return
            }
            
            
            // Ensure there is data in the response.
            guard let data = data else {
                let noDataError = NSError(domain: "No data", code: -1, userInfo: nil)
                completion(.failure(noDataError))
                return
            }

            let responseDataString = String(decoding: data, as: UTF8.self)
            if !responseDataString.isEmpty {
                var token = LoginResponse(success: true, token: responseDataString, message: "Success")
                completion(.success(token))
            }
            
            // Decode the JSON response.
            /*do {
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                print(decodedResponse)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }*/
        }
        
        // Start the data task.
        task.resume()
    }
}





