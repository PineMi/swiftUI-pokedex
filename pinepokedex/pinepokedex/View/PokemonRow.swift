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
                .padding(20)
                Spacer()
                
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                .padding(.trailing, 10)
            }
            .background(
                          Color(.systemGray6),
                          in: UnevenRoundedRectangle(
                              topLeadingRadius: 0,
                              bottomLeadingRadius: 0,
                              bottomTrailingRadius: 20,
                              topTrailingRadius: 20
                          )
                      )
    }
}

#Preview("Single Row") {
    PokemonRow(pokemon: MockData.samplePokemon)
        .padding()
}
