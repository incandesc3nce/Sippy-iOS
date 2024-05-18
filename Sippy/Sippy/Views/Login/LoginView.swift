//
//  StartView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI


struct LoginView: View {
    
    @State var loginService = APIServiceLogin()
    
    @Environment(\.presentationMode) var presentationMode

    @State private var email = ""
    @State private var password = ""
    
    @State private var notEnoughInfo = false
    @State private var incorrectInfo = false
    
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
                            Text("Email: ")
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
                        if email.isEmpty || password.isEmpty {
                            notEnoughInfo = true
                            
                        } else {
                            loginService.login(email: email, password: password) { result in
                                switch result {
                                case .success(let loginResponse):
                                    print("Login successful! Token: ")
                                    print(userToken)
                                    
                                    UserDefaults.standard.setValue(true, forKey: "loggedIn")
                                    presentingMainView.toggle()
                                case .failure(let error):
                                    print("Error occurred during login: \(error.localizedDescription)")
                                    incorrectInfo.toggle()
                                }
                            }
                            
                        }
                    }
                    // doesnt work idk why
                    .alert(isPresented: $notEnoughInfo) {
                        Alert(title: Text("Ошибка"), message: Text("Вы не ввели все данные!"), dismissButton: .default(Text("OK")) {
                                notEnoughInfo = false
                        })
                    }
                    .alert(isPresented: $incorrectInfo) {
                        Alert(title: Text("Ошибка"), message: Text("Не удалось войти в вашу учетную запись. Проверьте правильность введенных данных."), dismissButton: .default(Text("OK")) {
                                incorrectInfo = false
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
