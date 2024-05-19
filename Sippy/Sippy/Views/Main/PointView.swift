//
//  PointView.swift
//  Sippy
//
//  Created by Dmitry on 19.05.2024.
//

import SwiftUI

struct PointView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var tempLocation: Location?
    var location: Location
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Мероприятие")
                    .fontWeight(.thin)
                Text("Встреча в пабе #22")
            }
            .padding(.top)
            
            Divider()
            
            VStack {
                HStack {
                    Text("Тип мероприятия")
                        .fontWeight(.thin)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("Пабы")
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
            }
            VStack {
                HStack{
                    Text("Время")
                        .fontWeight(.thin)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .padding(.top, 5.0)
                    Spacer()
                }
                HStack {
                    Text("10:30 - 13:30")
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
            }
            VStack {
                HStack {
                    Text("Описание")
                        .fontWeight(.thin)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .padding(.top, 5.0)
                    Spacer()
                }
                HStack {
                    Text("С первомаем, дорогая, с самым ярким весенним днём")
                        .padding(.leading)
                    Spacer()
                }
            }
            Spacer()
            
            VStack {
                Button(action: {
                    
                }, label: {
                    Text("Откликнуться")
                        .fontWeight(.bold)
                })
                .padding(.all)
                
                .background(Color.orange)
                .accentColor(.white)
                .cornerRadius(10.0)
            }
            
            Spacer()
            
        }
    }
    
    init(location: Location, tempLocation: Binding<Location?>) {
        self.location = location
        self._tempLocation = tempLocation
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

