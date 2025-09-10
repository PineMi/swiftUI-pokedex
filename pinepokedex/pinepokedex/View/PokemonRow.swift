//
//  PokemonRow.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonRow: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        
        ZStack {
            Rectangle()
                .cornerRadius(25)
                .foregroundColor(.cardBackground)
            
            HStack {
                // Text
                VStack(alignment: .leading) {
                    Text("Nº 001").font(.headline)
                    Text("Bulbasaur").font(.title)
                    Text("Type")
                }
                .padding(.leading)
                
                
                Spacer()
                
                // Pokemon Image Square
                
                ZStack {
                    Rectangle()
                        .cornerRadius(25)
                        .frame(width: screenSize.width * 0.30, height: screenSize.height * 0.13)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(width: screenSize.width * 0.95, height: screenSize.height * 0.13)
    }
}

#Preview {
    PokemonRow()
}
