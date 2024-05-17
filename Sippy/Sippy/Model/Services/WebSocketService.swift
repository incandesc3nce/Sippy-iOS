//
//  WebSocketService.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import Foundation

class WebsocketService: ObservableObject {
    @Published var messages = [String]()
    
    private var webSocketTask: URLSessionWebSocketTask?
    var socketID: String = ""
    
    init() {
        self.connect()
    }
    
    private func connect() {
        guard let url = URL(string: "ws://79.174.80.34:8081/app/enutvdp2xjy23r3ajqfr") else { return }
        
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    private func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async { [self] in
                        self.messages.append(text)
                        socketID = getSocketID(text)
                        print("Socket ID: \(socketID)")
                    }
                    
                case .data(let data):
                    // handle binary data
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func getSocketID(_ message: String) -> String {
        guard let data = message.data(using: .utf8) else { return "" }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let dataString = json["data"] as? String,
            let dataData = dataString.data(using: .utf8),
            let dataJson = try JSONSerialization.jsonObject(with: dataData, options: []) as? [String: Any],
            let socketId = dataJson["socket_id"] as? String {
                return socketId
            }
        } catch {
            print("Failed to parse JSON: \(error)")
        }
        
        return ""
    }
    
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
