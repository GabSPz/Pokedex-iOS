//
//  PokedexView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokedexView: View {
    let pokedexUrl: String
    @StateObject private var viewModel: PokedexViewModel = .build()
    var body: some View {
        VStack {
            Text(viewModel.model.pokedexName)
            pokemons
            Text("Hola")
                .font(.largeTitle)
            
        }
        .onAppear{
            viewModel.getPokedex(url: pokedexUrl)
        }
    }
    
    var pokemons: some View {
        
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]) {
                ForEach(viewModel.model.pokemons, id: \.id) { pokemon in
                    NavigationLink{
                        PokemonView(pokemonId: pokemon.id)
                    } label: {
                        HStack {
                            Spacer()
                            Text(pokemon.name)
                                .foregroundColor(.primary)
                                .font(.caption.bold())
                            
                            Spacer()
                        }
                        
                        .frame(height: 150)
                        .background(.red)
                        .cornerRadius(10)
                        
                    }
                    .padding(2)
                }
            }
            .padding(.horizontal,20)
        }
        

    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(pokedexUrl:"https://pokeapi.co/api/v2/pokedex/1/")
    }
}
