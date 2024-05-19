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
    
    @Binding var tempLocation: Location?
    var location: Location
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Название:")
                        TextField("", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Тип мероприятия")
                        Picker("pubs", selection: $category) {
                            Text("Пабы").tag("pubs")
                            Text("Дома").tag("at_home")
                            Text("Кино").tag("cinema")
                            Text("Сабантуй").tag("sabantui")
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
                    newLocation.category = category
                    
                    pointService.sendLocation(newLocation)
                    
                    onSave(newLocation)
                    didCreatePlace = true
                    dismiss()
                }) {
                    Text("Создать")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Детали мероприятия")
            .navigationBarItems(trailing: Button("Отмена") {
                tempLocation = nil
                dismiss()
            })
        }
        .background(Color(hex: 0x057DC8))
        .onDisappear(perform: {
            if didCreatePlace == false {
                tempLocation = nil
            }
        }
        )
    }
    
    init(location: Location, tempLocation: Binding<Location?>, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        self._tempLocation = tempLocation
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

