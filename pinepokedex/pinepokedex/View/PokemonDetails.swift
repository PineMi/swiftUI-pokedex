//
//  PokemonDatails.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 10/09/25.
//

import SwiftUI

struct PokemonDetails: View {

    
    let pokemon: Pokemon?

    var body: some View {
        VStack {
            if let pokemon = pokemon {
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Height: \(pokemon.height)")
                Text("Weight: \(pokemon.weight)")
                ForEach(0..<6) { index in
                    Text("\(pokemon.stats[index].stat.name): \(pokemon.stats[index].baseStat)")
                }
            } else {
                ProgressView()
                Text("Fetching Pokémon...")
                    .padding(.top, 8)
            }
        }
    }
}

