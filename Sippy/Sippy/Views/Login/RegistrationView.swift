//
//  RegistrationView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var gender: Int = 0

    @State private var ageString = ""
    var age: Int? {
        Int(ageString)
    }
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var presentingMainView = false
    
    @State private var notEnoughInfo = false
    @State private var alreadyExists = false
    
    let regService = APIServiceRegister()
    
    var body: some View {
        Text("Регистрация")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
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
                                Text("Мужской").tag(0)
                                Text("Женский").tag(1)
                            }
                        }
                        HStack {
                            Text("Ваш возраст: ")
                            TextField("18", text: $ageString)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
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
                        if name == "" || email == "" || password == "" {
                            notEnoughInfo.toggle()
                        } else {
                            regService.register(name: name, email: email, password: password, gender: gender, age: age) { result in
                                switch result {
                                case .success(let success):
                                    if Bool(success)! {
                                        print("Registration successful!")
                                        presentingMainView.toggle()
                                    }
                                case .failure(let error):
                                    print("Registration failed: \(error.localizedDescription)")
                                    alreadyExists.toggle()
                                }
                            }
                            
                        }
                        // send request and check if valid
                        
                    }
                    // doesnt work idk why
                    .alert(isPresented: $notEnoughInfo) {
                        Alert(title: Text("Ошибка"), message: Text("Вы не ввели все данные!"), dismissButton: .default(Text("OK")) {
                            notEnoughInfo = false
                        })
                    }
                    .alert(isPresented: $alreadyExists) {
                        Alert(title: Text("Ошибка"), message: Text("Учетная запись с такими данными уже существует!"), dismissButton: .default(Text("OK")) {
                            alreadyExists = false
                        })
                    }
                    
                    
                    .fullScreenCover(isPresented: $presentingMainView, content: {
                        MainView()
                    })
                    .frame(maxWidth: .infinity)
                    Text("Я согласен на обработку персональных данных и прочитал политику конфедициальности.")
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
