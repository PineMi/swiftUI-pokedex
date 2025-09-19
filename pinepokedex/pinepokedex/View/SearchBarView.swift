//
//  SearchBarView.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 19/09/25.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:20)
                .foregroundColor(.blue)
                
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text("Pokedex")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius:20)
                            .foregroundStyle(.gray)
                            .frame(height: 40)
                        
                        Text("TEST")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }.frame(width: .infinity, height: 250)
    }
}



#Preview {
    SearchBarView()
}
