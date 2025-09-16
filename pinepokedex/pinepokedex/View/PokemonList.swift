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
            List {
                 ForEach(pokemons) { pokemon in
                     PokemonRow(pokemon: pokemon)
                         .background(
                             NavigationLink(destination: PokemonDetails(pokemon: pokemon)){}
                             .opacity(0)
                         )
                     
                     .swipeActions(edge: .leading, allowsFullSwipe: true) {
                         Button {
                             print("\(pokemon.name) favorited!")
                         } label: {
                             Label("Favorite", systemImage: "star.fill")
                         }
                         .tint(.yellow)
                     }
                     .padding(.trailing, 20)
                     .listRowInsets(EdgeInsets())
                     .listRowSeparator(.hidden)
                     .listRowBackground(Color.clear)
                 }
             }

             .listRowSpacing(8)
             .ignoresSafeArea(.all, edges: .leading)
            .overlay {
                if pokemons.isEmpty {
                    ProgressView("Catching Pokémon...")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokédex")
            .task {
                if pokemons.isEmpty {
                    do {
                        pokemons = try await service.fetchPokemonList(limit: 151)
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
