//
//  Pokemon.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 09/09/25.
//

import Foundation

// main Pokemon model
struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let types: [TypeElement]
    let sprites: Sprites
    let weight: Int
    let height: Int
    let stats: [StatElement]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case sprites
        case weight
        case height
        case stats
    }
}

struct TypeElement: Codable, Identifiable {
    let slot: Int
    let type: TypeInfo
    
    var id: Int { slot } // Provisório

}

struct TypeInfo: Codable {
    let name: String
    let url: String
}


struct Sprites: Codable {
    let frontDefault: String
    let other: OtherSprites? // Nesting Futuro

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSprites: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}


struct StatElement: Codable {
    let baseStat: Int
    let stat: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfo: Codable {
    let name: String
}
