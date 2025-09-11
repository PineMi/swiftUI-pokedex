//
//  PokemonList.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import SwiftUI

struct PokemonList: View {
    @State private var loadedPage: Int? = nil
    
    var body: some View {
        NavigationSplitView {
            ScrollView {
                if let _ = loadedPage {
                    LazyVStack{
                        ForEach(1..<50) { index in
                            PokemonRow(id:index)
                        }
                    }
                }
                else {
                    ProgressView()
                }
            }
        }
        detail: { Text("Select a Pokémon") }
        .onAppear { loadedPage = 1 }
    }
}

#Preview {
    PokemonList()
}
