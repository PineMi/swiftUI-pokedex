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

    @State private var zoomedSpriteURL: URL? = nil

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
                        .onLongPressGesture(minimumDuration: 0.5) {
                        } onPressingChanged: { isPressing in
                            withAnimation(.spring) {
                                if isPressing {
                                    zoomedSpriteURL = spriteUrl
                                } else {
                                    zoomedSpriteURL = nil
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        
        .overlay {
            if let url = zoomedSpriteURL {
            ZStack {
                Color.black.opacity(0.7).ignoresSafeArea()
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                        .transition(.scale.combined(with: .opacity))

                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .background(.thinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            }
        }
    }
}


// --- Helper Views ---

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
    var statElement: StatElement
    
    var body: some View {
        HStack {
            let statName = statElement.stat.name.capitalized.replacingOccurrences(of: "-", with: " ")
            Text(statName)
                .frame(width: 80, alignment: .leading)
            Text("\(statElement.baseStat)")
                .fontWeight(.medium)
                .frame(width: 40)
            
            ProgressView(value: Double(statElement.baseStat), total: 200)
                .tint(.blue)
        }
    }
}

#Preview {
    let samplePokemon = MockData.sampleCompletePokemon
    PokemonDetails(pokemon: samplePokemon)
}
