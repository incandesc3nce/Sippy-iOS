//
//  PersonProfileView.swift
//  Sippy
//
//  Created by Dmitry on 18.05.2024.
//

import SwiftUI

struct PersonProfileView: View {
    
    @State private var personName = "Мистер Кот"
    @State private var personAge = 20
    @State private var personBio = "Настоящий Мистер Кот"
    @State private var personTelegram = "@mrcat_official"
    
    
    var body: some View {
        VStack {
            HStack {
                Image("mr cat")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding([.top, .horizontal])
                
                VStack {
                    HStack {
                        Text("\(personName)")
                            .font(.title)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack {
                        Text("\(personAge) лет")
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                }
                    
                Spacer()
            }
            
            
            VStack {
                Form {
                    Section("О себе") {
                        Text("\(personBio)")
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                    }
                    Section("Telegram") {
                        Text("\(personTelegram)")
                    }
                    
                }
            }
        }
    }
}

#Preview {
    PersonProfileView()
}
