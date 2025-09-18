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
                    .padding(10)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .overlay {
                if pokemons.isEmpty {
                    ProgressView()
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search for a Pokémon or ID").tint(.white)
            .task {
                if pokemons.isEmpty {
                    do {
                        pokemons = try await service.fetchPokemonList(limit: 50)
                    } catch {
                        print("Error fetching Pokémon: \(error)")
                    }
                }
            }
            .background(
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .foregroundStyle(LinearGradient(colors: [.backgroundGray , .white], startPoint: .leading, endPoint: .topTrailing))
            )
            
        } detail: {
            Text("Select a Pokémon")
        }
    }
}


#Preview {
    PokemonList()
}
