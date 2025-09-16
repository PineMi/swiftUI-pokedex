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
    
    @State private var searchText = ""
    
    var filteredPokemons: [Pokemon] {
            if searchText.isEmpty {
                return pokemons
            } else {
                return pokemons.filter {
                    let nameMatch = $0.name.lowercased().contains(searchText.lowercased())
                    let idContainsMatch = String($0.id).contains(searchText)
                    let idExactMatch = String(format: "%03d", $0.id) == searchText
                    let typeMatch = $0.types.contains { type in
                        type.lowercased().contains(searchText.lowercased())
                    }
                    return nameMatch || idContainsMatch || idExactMatch || typeMatch
                }
            }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredPokemons) { pokemon in
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

             .listRowSpacing(8)
             .ignoresSafeArea(.all, edges: .leading)
             .overlay {
                 if pokemons.isEmpty {
                     ProgressView("Catching Pokémon...")
                 }
             }
             .listStyle(.plain)
             .navigationTitle("Pokédex")
             .searchable(text: $searchText, prompt: "Search for a Pokémon, ID or Type")
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
