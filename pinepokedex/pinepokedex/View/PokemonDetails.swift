//
//  PokemonDatails.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 10/09/25.
//

import SwiftUI

struct PokemonDetails: View {
    let pokemon: Pokemon
    let gridColumns: [GridItem] = [
            .init(.adaptive(minimum: 80))
        ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: pokemon.sprites.primary) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .shadow(radius: 5)
                
                // --- General Info ---
                VStack {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        ForEach(pokemon.types, id: \.self) { typeName in
                            TypeTagView(typeName: typeName)
                        }
                    }
                }
                
                // --- Physical Stats ---
                HStack(spacing: 30) {
                    StatPill(label: "Height", value: "\(String(format: "%.1f", pokemon.heightInMeters)) m")
                    StatPill(label: "Weight", value: "\(String(format: "%.1f", pokemon.weightInKg)) kg")
                }
                
                // --- Base Stats ---
                VStack(alignment: .leading, spacing: 12) {
                    Text("Base Stats")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(pokemon.stats, id: \.stat.name) { statElement in
                        StatRow(statElement: statElement)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // --- Gallery ---
                Text("Sprite Gallery")
                    .font(.headline)
                    .padding(.top)
                    
                LazyVGrid(columns: gridColumns, spacing: 12) {
                    ForEach(pokemon.sprites.gallery, id: \.self) { spriteUrl in
                        AsyncImage(url: spriteUrl) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                                        }
                }
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}


// --- Reusable Helper Views for Cleaner Code ---

struct StatPill: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}

struct StatRow: View {
    let statElement: StatElement
    
    var body: some View {
        HStack {
            Text(statElement.stat.name.capitalized)
                .frame(width: 80, alignment: .leading)
            Text("\(statElement.baseStat)")
                .fontWeight(.medium)
                .frame(width: 40)
            
            // A simple progress bar to visualize the stat
            ProgressView(value: Double(statElement.baseStat), total: 200)
                .tint(.blue)
        }
    }
}

