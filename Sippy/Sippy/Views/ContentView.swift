//
//  ContentView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    
    //@ObservedObject var registration = APIServiceRegister()
    //@ObservedObject var login = APIServiceLogin()
    
    
    //@ObservedObject var websocket = WebsocketService()
    

    var body: some View {
        if let isLoggedIn = UserDefaults.standard.string(forKey: "loggedIn") {
            MainView()
        } else {
            LoginView()
        }
        
        
        
    }

    
}

#Preview {
    ContentView()
}
