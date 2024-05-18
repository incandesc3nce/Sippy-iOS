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
    @State private var telegram = ""
    @State private var gender: Int = 1
    
    @State private var tryingToLogOff = false
    @State private var loggedOff = false
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color(red: 0.008, green: 0.49, blue: 0.788))
                .clipShape(Circle())
                .overlay(content: {
                    Image("Logo_v2")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 170, height: 170)
                        .cornerRadius(55)
                })
            
            
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
                            
                    }
                    Section {
                        HStack {
                            Text("Имя: ")
                            TextField("example", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Telegram: ")
                            TextField("@example", text: $telegram)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Пол: ")
                            Picker("", selection: $gender) {
                                Text("Мужской").tag(1)
                                Text("Женский").tag(0)
                            }
                        }
                    }
                    Section {
                        
                    }
                    Section {
                        Button(action: {
                            tryingToLogOff = true
                            
                            
                        }) {
                            Text("Выйти из профиля")
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity)
                        
                        .alert(isPresented: $tryingToLogOff) {
                            Alert(title: Text("Выход"), message: Text("Вы уверены, что хотите выйти из своей учетной записи?"), primaryButton: .destructive(Text("Да")) {
                                loggedOff = true
                                loggedIn = false
                                UserDefaults.standard.set(loggedIn, forKey: "loggedIn")
                            }, secondaryButton: .cancel(Text("Отмена")))
                        }
                        .fullScreenCover(isPresented: $loggedOff) {
                            LoginView()
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
