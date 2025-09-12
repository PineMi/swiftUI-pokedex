//
//  PokemonList.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonList: View {
    @State private var pokemons: [Pokemon] = []
    private let service = PokemonService()
    
    var body: some View {
        NavigationSplitView {
            List(pokemons) { pokemon in
                PokemonRow(pokemon: pokemon)
                    // Hide the default list row separators for a custom card look.
                    .listRowSeparator(.hidden)
            }
            // Show a progress view as an overlay while the list is empty.
            .overlay {
                if pokemons.isEmpty {
                    ProgressView("Catching Pokémon...")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokédex")
            // Use .task for modern async calls.
            .task {
                // Ensure we only fetch data once.
                if pokemons.isEmpty {
                    do {
                        pokemons = try await service.fetchPokemonList(limit: 151) // Fetch Gen 1
                    } catch {
                        print("Error fetching Pokémon: \(error)")
                    }
                }
            }
        } detail: {
            Text("Select a Pokémon")
        }
    }
}


#Preview {
    PokemonList()
}
