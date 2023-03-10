//
//  PokedexViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

class PokedexViewModel: ObservableObject {
    @Published var model: Pokedex = .init(pokedexName: "", pokemons: [])
    @Published var messageError: String = ""
    private let useCase: PokedexUseCaseProtocol
    
    init(useCase: PokedexUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func getPokedex(url: String) {
        useCase.getOnePokedex(url: url) { [weak self] result in
            switch result {
            case .success(let pokedex):
                self?.model = pokedex
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}
