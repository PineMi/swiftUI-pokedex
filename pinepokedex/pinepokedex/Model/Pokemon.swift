import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let types: [String]
    let sprites: Sprites
    let weight: Int // In hectograms
    let height: Int // In decimetres
    let stats: [StatElement]
    
    var weightInKg: Double { Double(weight) / 10.0 }
    var heightInMeters: Double { Double(height) / 10.0 }

    
    init(from decoder: Decoder) throws {

        struct TypeElement: Codable {
            let type: TypeInfo
        }
        struct TypeInfo: Codable {
            let name: String
        }
        
        enum CodingKeys: String, CodingKey {
            case id, name, types, sprites, weight, height, stats
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode standard properties
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        weight = try container.decode(Int.self, forKey: .weight)
        height = try container.decode(Int.self, forKey: .height)
        stats = try container.decode([StatElement].self, forKey: .stats)
        
        var decodedTypes: [TypeElement] = try container.decode([TypeElement].self, forKey: .types)
        self.types = decodedTypes.map { $0.type.name }
    }
}


// --- Supporting Models ---
struct Sprites: Codable {
    let frontDefault: String
    let other: OtherSprites?

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
