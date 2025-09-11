//
//  PokemonRow.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonRow: View {
    let id: Int
    @State private var pokemon: Pokemon?
    
    var body: some View {
        
        let screenSize = UIScreen.main.bounds.size
        
        ZStack {
            Rectangle()
                .cornerRadius(25)
                .foregroundColor(.cardBackground)
            if let pokemon = pokemon {
                HStack {
                    // Text
                    VStack(alignment: .leading) {
                        Text("Nº \(pokemon.id)").font(.headline)
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        HStack {
                            ForEach (pokemon.types) { type in
                                Text(type.type.name.capitalized)
                                    .font(.caption)
    
                            }
                        }
                    }
                    .padding(.leading)
                    Spacer()
                    // Pokemon Image Square
                    ZStack {
                        Rectangle()
                            .cornerRadius(25)
                            .frame(width: screenSize.width * 0.30, height: screenSize.height * 0.13)
                            .foregroundColor(.secondary)
                        AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenSize.width * 0.30, height: screenSize.height * 0.13)
                        } placeholder: { ProgressView() }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            fetchPokemon(id: id) { fetchedPokemon in
                self.pokemon = fetchedPokemon
            }
        }
        .frame(width: screenSize.width * 0.95, height: screenSize.height * 0.13)
        
    }
}

#Preview {
    PokemonRow(id:1)
}
