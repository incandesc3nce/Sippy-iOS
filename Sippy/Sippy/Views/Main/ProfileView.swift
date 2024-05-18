//
//  ProfileView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI


struct ProfileView: View {
    
    @State private var bioText = ""
    @State private var name = ""
    
    var body: some View {
        VStack {
            Image("Logo_v2")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            Divider()
            Text("\(localUser.name)")
                .font(.largeTitle)
            
            VStack {
                Form {
                    Section("О себе") {
                        TextField("24 года, программист из Барнаула", text: $bioText)
                            .multilineTextAlignment(.leading)
                        Text("Можно указать любые подробности")
                            .font(.callout)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                    }
                    Section {
                        HStack {
                            Text("Имя: ")
                            TextField("example", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Telegram: ")
                            TextField("@example", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Пол: ")
                            TextField("Мужской", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
            
            
        }
        
    }
}

#Preview {
    ProfileView()
}
