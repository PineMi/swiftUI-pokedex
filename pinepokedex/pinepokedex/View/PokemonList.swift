//
//  PokemonList.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonList: View {
    @State private var pokemonList: [Pokemon] = []
    
    var body: some View {
        NavigationSplitView {
            if pokemonList.isEmpty {
                ProgressView()
            }
            else {
                List {
                    PokemonRow()
                }
                .navigationTitle("Pokémons")
            }
        } detail: {
            Text("Select a Pokémon")
        }
        .onAppear {
        }
        
    }
}

#Preview {
    PokemonList()
}
