//
//  ColorSelection.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 12/09/25.
//

import Foundation
import SwiftUICore

func typeColor(pokemon_type: String) -> Color {
    switch pokemon_type {
    case "normal":
        return .normal
    case "fire":
        return .fire
    case "water":
        return .water
    case "grass":
        return .grass
    case "electric":
        return .electric
    case "ice":
        return .ice
    case "fighting":
        return .fighting
    case "poison":
        return .poison
    case "ground":
        return .ground
    case "flying":
        return .flying
    case "psychic":
        return .psychic
    case "bug":
        return .bug
    case "rock":
        return .rock
    case "ghost":
        return .ghost
    case "dragon":
        return .dragon
    case "dark":
        return .dark
    case "steel":
        return .steel
    case "fairy":
        return .fairy
    default:
        return Color.gray
    }
}
