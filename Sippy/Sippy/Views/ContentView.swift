//
//  ContentView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    //@ObservedObject var registration = APIServiceRegister()
    //@ObservedObject var login = APIServiceLogin()
    
    
    //@ObservedObject var websocket = WebsocketService()
    

    var body: some View {
        LoginView()
        
        
    }

    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
