//
//  PersonProfileView.swift
//  Sippy
//
//  Created by Dmitry on 18.05.2024.
//

import SwiftUI

struct PersonProfileView: View {
    
    @State private var personName = "Mr Penis"
    @State private var personAge = 20
    @State private var personBio = "Настоящий Mr Penis"
    @State private var personTelegram = "@mrpenis_official"
    
    
    var body: some View {
        VStack {
            HStack {
                Image("Logo_v2")
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
