//
//  PokemonRow.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI



func getGradient(pokemon: Pokemon) -> LinearGradient {
    let Gradcolor1: Color = typeColor(pokemon_type: pokemon.types[0])
    let Gradcolor2: Color = pokemon.types.count == 1 ? Gradcolor1.opacity(0.5) : typeColor(pokemon_type: pokemon.types[1])
    return LinearGradient(colors: [Gradcolor1, Gradcolor1, Gradcolor2], startPoint: .leading, endPoint: .trailing)
}

struct TypeTagView: View {
    let typeName: String
    var body: some View {
        Text(typeName.capitalized)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.pokemonNameWhite)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(typeColor(pokemon_type: typeName)))
            .cornerRadius(5)
            .shadow(radius: 5, y: 6)
    }
}


struct PokemonRow: View {
    let pokemon: Pokemon
    
    
    var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(String(format: "#%03d", pokemon.id))
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.pokemonIdBlack)
                        
                    
                    Text(pokemon.name.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.pokemonNameWhite)
                    
                    HStack {
                        ForEach(pokemon.types, id: \.self) { typeName in
                            TypeTagView(typeName: typeName)
                        }
                    }
                }
                .padding(20)
                Spacer()
                AsyncImage(url: pokemon.sprites.primary) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .cornerRadius(20)
                .padding(.trailing, 10)
            }
            .background(
                ZStack {
                    getGradient(pokemon: pokemon).opacity(0.9).brightness(-0.1)
                    
                    Image(.thickToThinDotsPattern)
                        .resizable()
                        .opacity(0.4)
                        .scaledToFit()
                        .colorInvert()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 150, height: 200)
                        .padding(.leading, -180)
                    
                }
            )
            .cornerRadius(10)
    }
}

#Preview("Single Row") {
    PokemonRow(pokemon: MockData.pokemonList[1])
}
