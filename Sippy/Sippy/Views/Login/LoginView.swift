//
//  StartView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

struct StartView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Form {
                    Section("Вход в Sippy") {
                        TextField("example@mail", text: $email)
                            .keyboardType(.emailAddress)
                        
                        
                        SecureField("******", text: $password)
                        
                       
                        
                    }
                    
                    Section {
                        Button("Войти") {
                            // send request and check if valid
                        }
                        .frame(maxWidth: .infinity)
                        Button("Меня еще нет в Sippy") {
                            // show new view
                        }
                        .font(.system(size: 16, weight: .thin))
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                
            }
        }
    }
}

#Preview {
    StartView()
}
