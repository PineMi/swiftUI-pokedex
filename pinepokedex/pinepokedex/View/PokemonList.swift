//
//  PokemonList.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonList: View {
    
    @State private var pokemons: [Pokemon] = []
    @State private var searchText = ""
    private let service = PokemonService()
    

    var filteredPokemons: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            let searchTextLowercased = searchText.lowercased()
            return pokemons.filter { pokemon in
                let nameMatches = pokemon.name.lowercased().contains(searchTextLowercased)
                
                let idContainsMatch = String(pokemon.id).contains(searchText)
                
                let idExactMatch = String(format: "%03d", pokemon.id) == searchText
                
                let typeMatches = pokemon.types.contains { type in
                    type.lowercased().contains(searchTextLowercased)
                }
                return nameMatches || idContainsMatch || idExactMatch || typeMatches
            }
        }
    }
    
    
    var body: some View {
        NavigationSplitView {
            ZStack {
                Background()
                VStack(spacing: 0) {

                    SearchBarView(text: $searchText).ignoresSafeArea()
                    
                    List(filteredPokemons) { pokemon in
                        PokemonRow(pokemon: pokemon)
                            .background(
                                NavigationLink(destination: PokemonDetails(pokemon: pokemon)){}
                                    .opacity(0)
                            )
                            .padding(.horizontal, 10)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .overlay {
                        if pokemons.isEmpty {
                            ProgressView("Catching Pokémon...")
                        } else if filteredPokemons.isEmpty {
                            ContentUnavailableView.search
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .task {
                if pokemons.isEmpty {
                    do {
                        pokemons = try await service.fetchPokemonList(limit: 1302)
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
