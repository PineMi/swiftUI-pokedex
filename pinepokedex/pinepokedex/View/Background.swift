//
//  Background.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 19/09/25.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(LinearGradient(colors: [.white, .backgroundGray], startPoint: .bottomLeading, endPoint: .topTrailing))
            
            Image(.pokeballwatermark)
                .opacity(0.3)
                .offset(x: 70, y: -40)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

#Preview {
    Background()
}
