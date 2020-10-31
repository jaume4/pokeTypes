//
//  PokemonView.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import SwiftUI

struct PokemonView: View {
    
    let pokemon: Pokemon
    static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        return formatter
    }
    
    var body: some View {
        
        HStack {
        
            Text(PokemonView.formatter.string(from: NSNumber(value: pokemon.pokedex))! + "  " + pokemon.name)
            
            Spacer()
            
            Text(pokemon.type1.name)
                .modifier(CapsuleModifier(selected: false, id: pokemon.type1.id))
            
            if let type2 = pokemon.type2 {
                Text(type2.name)
                    .modifier(CapsuleModifier(selected: false, id: type2.id))
            }
            
        }
    }
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}

struct PokemonView_Previews: PreviewProvider {
    
    static var pokemon: Pokemon {
        let pokemons: [Pokemon] = try! PersistenceController.shared.container.viewContext.fetch(Pokemon.fetchRequest())
        return pokemons.first(where: { $0.type2 != nil })!
    }

    static var previews: some View {
        VStack {
            PokemonView(pokemon)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
    }
}
