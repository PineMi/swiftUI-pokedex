import Foundation

struct PokemonService {
    func fetchPokemon(id: Int) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id <= 1025 ? id : id + 8975)/") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        return pokemon
    }
    
    
    func fetchPokemonList(limit: Int) async throws -> [Pokemon] {
        var pokemons: [Pokemon] = []
        
        try await withThrowingTaskGroup(of: Pokemon.self) { group in
            for id in 1...limit {
                group.addTask {
                    return try await fetchPokemon(id: id)
                }
            }
            
            for try await pokemon in group {
                pokemons.append(pokemon)
            }
        }
        
        return pokemons.sorted { $0.id < $1.id }
    }
}
