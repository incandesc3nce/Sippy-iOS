//
//  APIService.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import Foundation

class APIServiceRegister: ObservableObject {
    var decodedAnswer: String = ""
    
    
    init() {
        register(name: "ios_21_22", email: "ios_device@mail.ru", password: "test_test")
    }

    func register(name: String, email: String, password: String) {
        guard let url = URL(string: "http://79.174.80.34:8081/api/registration") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            print(parameters)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response, error == nil else {
                print("Something went wrong: error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            print(response)

            self.decodedAnswer = String(decoding: data, as: UTF8.self)
            
            
        }

        task.resume()
    }
}

class APIServiceLogin: ObservableObject {
    var decodedAnswer: String = ""
    
    init() {
        login(name: "ios_21_22", password: "test_test")
    }

    func login(name: String, password: String) {
        guard let url = URL(string: "http://79.174.80.34:8081/api/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "name": name,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            print(parameters)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response, error == nil else {
                print("Something went wrong: error: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            print(response)

            self.decodedAnswer = String(decoding: data, as: UTF8.self)

            
        }

        task.resume()
    }
}

