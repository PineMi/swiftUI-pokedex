import Foundation

// --- Main Model ---

struct Pokemon: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let types: [String]
    let sprites: Sprites
    let weight: Int // In hectograms
    let height: Int // In decimetres
    let stats: [StatElement]
    
    // Computed properties for easy display in standard units
    var weightInKg: Double { Double(weight) / 10.0 }
    var heightInMeters: Double { Double(height) / 10.0 }

    // Custom decoder to handle the nested 'types' array
    init(from decoder: Decoder) throws {
        // Helper structs to match the JSON structure for 'types'
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
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        weight = try container.decode(Int.self, forKey: .weight)
        height = try container.decode(Int.self, forKey: .height)
        stats = try container.decode([StatElement].self, forKey: .stats)
        
        let decodedTypes: [TypeElement] = try container.decode([TypeElement].self, forKey: .types)
        self.types = decodedTypes.map { $0.type.name }
    }
    
    // Hashable conformance
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// --- Supporting Models ---

struct Sprites: Codable, Hashable {
    let primary: URL?
    let gallery: [URL]

    // A custom decoder that digs through the JSON to find all image URLs.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        // Find the high-quality "official-artwork" as the primary image.
        if let otherContainer = try? container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .init(stringValue: "other")!),
           let artworkContainer = try? otherContainer.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .init(stringValue: "official-artwork")!),
           let urlString = try? artworkContainer.decode(String.self, forKey: .init(stringValue: "front_default")!) {
            self.primary = URL(string: urlString)
        } else {
            // Fallback to the regular front_default if official artwork isn't found.
            if let urlString = try? container.decode(String.self, forKey: .init(stringValue: "front_default")!) {
                self.primary = URL(string: urlString)
            } else {
                self.primary = nil
            }
        }
        
        // This recursive function finds every "front_default" URL in the JSON tree.
        func findImageUrls(in container: KeyedDecodingContainer<DynamicCodingKey>) -> [URL] {
            var urls: [URL] = []
            for key in container.allKeys {
                if key.stringValue.hasPrefix("front"),
                   let urlString = try? container.decode(String.self, forKey: key),
                   let url = URL(string: urlString) {
                    urls.append(url)
                }
                
                if let nestedContainer = try? container.nestedContainer(keyedBy: DynamicCodingKey.self, forKey: key) {
                    urls.append(contentsOf: findImageUrls(in: nestedContainer))
                }
            }
            return urls
        }
        
        self.gallery = findImageUrls(in: container)
    }
    
    private struct DynamicCodingKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int?
        init?(intValue: Int) { return nil }
    }
}

struct StatElement: Codable, Hashable {
    let baseStat: Int
    let stat: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfo: Codable, Hashable {
    let name: String
}
