//
//  PokemonOverview.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 17/09/25.
//

import SwiftUI

struct PokemonOverview: View {
    let pokemon: Pokemon
   
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                // --- General Info ---
                VStack(alignment: .leading){
                    Text(pokemon.name.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    
                    HStack {
                        ForEach(pokemon.types, id: \.self) { typeName in
                            TypeTagView(typeName: typeName)
                        }
                    }
                    
                    HStack(spacing: 30) {
                        Text("\(String(format: "%.1f", pokemon.heightInMeters)) m").bold()
                        Text("\(String(format: "%.1f", pokemon.weightInKg)) kg").bold()
                    }
                    .padding(.top, 5)
                }
                Spacer()
                
                // --- Base Stats ---
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(pokemon.stats, id: \.stat.name) { statElement in
                        if statElement.stat.name != "special-defense" && statElement.stat.name != "special-attack" {
                            HStack{
                                Text(statElement.stat.name.capitalized)
                                Spacer()
                                Text(statElement.baseStat.description).bold()
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
            }
            .padding()
        }
    }
}

#Preview {
    let samplePokemon = MockData.sampleCompletePokemon
    PokemonOverview(pokemon: samplePokemon)
}
