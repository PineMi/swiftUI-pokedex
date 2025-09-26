//
//  SearchBarView.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 19/09/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius:20)
                .foregroundColor(Color(.systemGray5))
            
            VStack {
                Spacer()
                VStack(spacing: 15) {
                    HStack {
                        Text("Pokédex")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .foregroundColor(.primary)
                            .padding(.leading, 20)
                        Spacer()
                    }

                    TextField("Search for a Pokémon or ID", text: $text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 15)
                }
            }
        }.frame(height: 180)
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
