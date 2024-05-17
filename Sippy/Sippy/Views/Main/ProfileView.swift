//
//  ProfileView.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI


struct ProfileView: View {
    
    
    var body: some View {
        VStack {
            Image("Logo_v2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            Rectangle()
                .fill(Color.gray)
                .frame(maxHeight: 3)
            Text("Иван")
                .font(.largeTitle)
            
            HStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 3)
                    .cornerRadius(3)
                    .frame(width: 350, height: 160)
                    .overlay(
                        VStack {
                            Text("Параметры")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.vertical)
                            HStack {
                                Text("Lorem ipsum")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Text("Lorem ipsum")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Text("Lorem ipsum")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Text("Lorem ipsum")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                    )
            }
            
            HStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 3)
                    .cornerRadius(3)
                    .frame(width: 350, height: 250)
                    .overlay(
                        VStack {
                            Text("О себе")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.vertical)
                            HStack {
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        
                    )
            }
            
        }
        Spacer()
    }
}

#Preview {
    ProfileView()
}
