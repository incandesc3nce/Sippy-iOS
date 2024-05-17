//
//  StartView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var showAlert = false
    
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
                            TextField("example", text: $email)
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
                        if email == "" || password == "" {
                            showAlert = true
                            
                        }
                        // send request and check if valid
                        // presentingMainView.toggle()
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Ошибка"), message: Text("Вы не ввели все данные!"), dismissButton: .default(Text("OK")) {
                            showAlert = false
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
