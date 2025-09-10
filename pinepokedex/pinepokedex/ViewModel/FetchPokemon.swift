//
//  FetchPokemonList.swift
//  pinepokedex
//
//  Created by Miguel Piñeiro on 10/09/25.
//

import Foundation


func fetchPokemon(id: Int, completion: @escaping (Pokemon?) -> Void) {
    
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
        print("Invalid URL")
        completion(nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            if let pokemon = try? decoder.decode(Pokemon.self, from: data) {
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            } else {
                print("Failed to decode JSON.")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        } else if let error = error {
            print("Network request failed: \(error)")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    task.resume()
}
