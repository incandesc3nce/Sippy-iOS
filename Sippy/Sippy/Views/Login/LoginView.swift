//
//  StartView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var loginService = APIServiceLogin()
    @State var userToken: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var password = ""
    
    @State private var notEnoughInfo = false
    
    @State private var presentingMainView = false
    
    @State private var presentingRegView = false
    var body: some View {
            VStack {
                Text("Sippy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
        Spacer()
            VStack {
                Section() {
                    Form {
                        HStack {
                            Text("Никнейм: ")
                            TextField("example", text: $name)
                                .keyboardType(.emailAddress)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Пароль: ")
                            SecureField("******", text: $password)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .frame(maxHeight: 150)
                    .background(Color.white)
                    
                }
                Spacer()
                
                VStack {
                    Button("Войти") {
                        if name.isEmpty || password.isEmpty {
                            notEnoughInfo = true
                            
                        } else {
                            loginService.login(name: name, password: password) { result in
                                switch result {
                                case .success(let loginResponse):
                                    if loginResponse.success {
                                        if let token = loginResponse.token {
                                            print("Login successful! Token: ")
                                            userToken = token
                                            print(userToken)
                                            // You can now use the token for further API requests
                                        } else {
                                            print("Login successful but no token received.")
                                        }
                                    } else {
                                        if let message = loginResponse.message {
                                            print("Login failed: \(message)")
                                        } else {
                                            print("Login failed with no message.")
                                        }
                                    }
                                case .failure(let error):
                                    print("Error occurred during login: \(error.localizedDescription)")
                                }
                            }
                            presentingMainView.toggle()
                        }
                        // send request and check if valid
                        
                        
                    }
                    .alert(isPresented: $notEnoughInfo) {
                        Alert(title: Text("Ошибка"), message: Text("Вы не ввели все данные!"), dismissButton: .default(Text("OK")) {
                            notEnoughInfo = false
                        })
                    }
                    
                    .fullScreenCover(isPresented: $presentingMainView, content: {
                        MainView()
                    })
                    .contentShape(Rectangle())
                    .padding(.horizontal, 100.0)
                    .padding(.vertical, 15.0)
                    .background(Color.orange.opacity(0.5))
                    .accentColor(.black)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    Button("Меня еще нет в Sippy") {
                        presentingRegView.toggle()
                    }
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity)
                    .accentColor(.blue)
                    
                    .sheet(isPresented: $presentingRegView, content: {
                        RegistrationView()
                    })
                    
                    
                }
                Spacer()
                
                
            }
    }
}

#Preview {
    LoginView()
}
