//
//  RegistrationView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var gender = false
    @State private var email = ""
    @State private var password = ""
    
    @State private var presentingMainView = false
    
    var body: some View {
        Text("Регистрация")
            .font(.largeTitle)
            .fontWeight(.bold)
        Section {
            
            VStack {
                Form {
                    Section("Ваши данные") {
                        HStack {
                            Text("Ваш никнейм: ")
                            TextField("username", text: $name)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Пол: ")
                            Picker("", selection: $gender) {
                                Text("Мужской").tag(false)
                                Text("Женский").tag(true)
                            }
                        }
                        HStack {
                            Text("Email: ")
                            TextField("example@mail", text: $email)
                                .keyboardType(.emailAddress)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("Пароль: ")
                            SecureField("******", text: $password)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        
                        
                    }
                    
                    
                    
                    Button("Зарегистрироваться") {
                        // send request and check if valid
                        presentingMainView.toggle()
                    }
                    .fullScreenCover(isPresented: $presentingMainView, content: {
                        MainView()
                    })
                    .frame(maxWidth: .infinity)
                    Text("Я согласен на обработку персональных данных и прочитал политику конфедициальности")
                    .font(.system(size: 16, weight: .ultraLight))
                    .accentColor(.blue)
                    
                }
                
            }
            
        }
        
    }
}

#Preview {
    RegistrationView()
}
