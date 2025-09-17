//
//  LoadingView.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 17/09/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            
            ProgressView("Catching Pokémon...")
        }
    }
}

#Preview {
    LoadingView()
}
