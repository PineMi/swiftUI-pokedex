//
//  MockData.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 12/09/25.
//

import Foundation

struct MockData {
    
    static let samplePokemon: Pokemon = uniquePokemonList[0]
    
    static let pokemonList: [Pokemon] = {
        return (0..<7).flatMap { _ in uniquePokemonList }
    }()
    
    private static let uniquePokemonList: [Pokemon] = {
        return try! JSONDecoder().decode([Pokemon].self, from: samplePokemonArrayData)
    }()
    
    private static let samplePokemonArrayData = """
    [
        {
            "id": 1, "name": "bulbasaur", "height": 7, "weight": 69,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png" },
            "stats": [ { "base_stat": 45, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "grass" } }, { "type": { "name": "poison" } } ]
        },
        {
            "id": 4, "name": "charmander", "height": 6, "weight": 85,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png" },
            "stats": [ { "base_stat": 39, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "fire" } } ]
        },
        {
            "id": 7, "name": "squirtle", "height": 5, "weight": 90,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png" },
            "stats": [ { "base_stat": 44, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "water" } } ]
        },
        {
            "id": 25, "name": "pikachu", "height": 4, "weight": 60,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png" },
            "stats": [ { "base_stat": 35, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "electric" } } ]
        },
        {
            "id": 39, "name": "jigglypuff", "height": 5, "weight": 55,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png" },
            "stats": [ { "base_stat": 115, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "normal" } }, { "type": { "name": "fairy" } } ]
        },
        {
            "id": 133, "name": "eevee", "height": 3, "weight": 65,
            "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/133.png" },
            "stats": [ { "base_stat": 55, "stat": { "name": "hp" } } ],
            "types": [ { "type": { "name": "normal" } } ]
        }
    ]
    """.data(using: .utf8)!
}
