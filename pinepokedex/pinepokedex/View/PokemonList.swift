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
        
    // TODO
    // Na tela de Detalhes do pokemon, recriar o design
    // Criar a tela do smart filter conforme protótipo
    // Adicionar o sorting e filtering
    // Design para a search Bar

    
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
            ZStack {
                Background()
                VStack {
                    //SearchBarView()
                    List(filteredPokemons) { pokemon in
                        PokemonRow(pokemon: pokemon)
                            .background(
                                NavigationLink(destination: PokemonDetails(pokemon: pokemon)){}
                                    .opacity(0)
                            )
                        
                        
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
                    .task {
                        if pokemons.isEmpty {
                            do {
                                pokemons = try await service.fetchPokemonList(limit: 1302)
                            } catch {
                                print("Error fetching Pokémon: \(error)")
                            }
                        }
                    }
                }
                .offset(y: 40)
            }
        } detail: {
            Text("Select a Pokémon")
        }
    }
}


#Preview {
    PokemonList()
}
