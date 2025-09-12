//
//  PokemonRow.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct TypeTagView: View {
    let typeName: String
    var body: some View {
        Text(typeName.capitalized)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(typeColor(pokemon_type: typeName)))
            .cornerRadius(20)
    }
}


struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        NavigationLink(destination: PokemonDetails(pokemon: pokemon)) {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(String(format: "#%03d", pokemon.id))
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(pokemon.name.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack {
                        ForEach(pokemon.types, id: \.self) { typeName in
                            TypeTagView(typeName: typeName)
                        }
                    }
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(20)
        }
        .buttonStyle(.plain)
    }
}

#Preview("Single Row") {
    PokemonRow(pokemon: MockData.samplePokemon)
        .padding()
}

#Preview("In a List") {
    List {
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
        PokemonRow(pokemon: MockData.samplePokemon)
    }
    .listStyle(.plain)
}
