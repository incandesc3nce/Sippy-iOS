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
    
    let pointService = APIPointService()
    
    var location: Location
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var typeOfEvent: Int = 0
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Название:")
                        TextField("", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Тип мероприятия")
                        Picker("", selection: $typeOfEvent) {
                            Text("Не дома").tag(0)
                            Text("Дома").tag(1)
                        }
                    }
                    HStack {
                        Text("Описание:")
                        TextField("", text: $description)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                    
                }
                
                Button(action: {
                    var newLocation = location
                    newLocation.name = name
                    newLocation.description = description
                    newLocation.typeOfEvent = typeOfEvent
                    
                    pointService.sendLocation(newLocation)
                    
                    onSave(newLocation)
                    didCreatePlace = true
                    dismiss()
                }) {
                    Text("Создать")
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

