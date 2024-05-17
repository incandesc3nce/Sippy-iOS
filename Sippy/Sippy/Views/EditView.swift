//
//  EditView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

var didCreatePlace = false

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                    
                }
                
                Button(action: {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    didCreatePlace = true
                    dismiss()
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Place Details")
        }
        .background(Color(hex: 0x057DC8))
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

