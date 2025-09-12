//
//  MockData.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 12/09/25.
//

import Foundation


struct MockData {
    static let samplePokemon: Pokemon = {
        return try! JSONDecoder().decode(Pokemon.self, from: samplePokemonData)
    }()
    
    private static let samplePokemonData = """
    {
        "id": 1,
        "name": "bulbasaur",
        "height": 7,
        "weight": 69,
        "sprites": {
            "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            "other": {
                "official-artwork": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                }
            }
        },
        "stats": [
            {
                "base_stat": 45,
                "stat": {
                    "name": "hp"
                }
            },
            {
                "base_stat": 49,
                "stat": {
                    "name": "attack"
                }
            },
            {
                "base_stat": 49,
                "stat": {
                    "name": "defense"
                }
            }
        ],
        "types": [
            {
                "slot": 1,
                "type": {
                    "name": "grass"
                }
            },
            {
                "slot": 2,
                "type": {
                    "name": "poison"
                }
            }
        ]
    }
    """.data(using: .utf8)!
}
