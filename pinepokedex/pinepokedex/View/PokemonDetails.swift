//
//  PokemonDatails.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 10/09/25.
//

// This would be your SwiftUI view file
import SwiftUI

struct PokemonDetailView: View {

    let pokemonId: Int
    
    @State private var pokemon: Pokemon?

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

            } else {
                ProgressView()
                Text("Fetching Pokémon...")
                    .padding(.top, 8)
            }
        }
        .onAppear {
            fetchPokemon(id: pokemonId) { fetchedPokemon in
                self.pokemon = fetchedPokemon
            }
        }
    }
}

#Preview {
    PokemonDetailView(pokemonId: 4)
}
