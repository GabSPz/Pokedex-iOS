//
//  PokemonUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonUseCase: PokemonUseCaseProtocol {
    private let pokemonService: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol) {
        self.pokemonService = pokemonService
    }
    
    func getPokemon(id: Int, completion: @escaping(Result<Pokemon, Error>) -> Void) {
        pokemonService.getOnePokemon(id: id) { result in
            switch result {
            case .success(let pokemonResponse):
                guard let pokemonResponse = pokemonResponse else { return }
                self.pokemonService.getEvolution(url: pokemonResponse.evolution_chain.url) { evoResult in
                    switch evoResult {
                    case .success(let success):
                        guard let success = success else { return }
                        let evolutions = self.mapEvo(evolutions: success)
                        completion(.success(.init(name: pokemonResponse.name, id: pokemonResponse.id, color: pokemonResponse.color.name, evolutionChainUrl: pokemonResponse.evolution_chain.url, pokemonEvolutions: evolutions)))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapEvo(evolutions: EvolutionResponse) -> [PokemonEvolutions]{
        //Unifying the evolutions in a only list
        var flag = true
        var evo: [ChainEvolutionResponse] = []
        var list: [ChainEvolutionResponse] = []
        evo.append(evolutions.chain)
        while flag {
            for i in evo.indices {
                let pokemon = evo[i]
                list.append(pokemon)
                if !evo[i].evolves_to.isEmpty {
                    evo.removeAll()
                    evo.append(contentsOf: pokemon.evolves_to)
                } else {
                    flag = false
                }
            }
        }
        let pokemonEvolutions = list.map { chain in
            PokemonEvolutions(evoName: chain.species.name, evoId: chain.species.url.getPokemonIdByUrl())
        }
        return pokemonEvolutions
    }
    
}
