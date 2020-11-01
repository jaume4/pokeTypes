//
//  PokemonFilteredView.swift
//  PokeTypes
//
//  Created by Jaume on 01/11/2020.
//

import SwiftUI

struct PokemonFilteredView: View {
    
    var fetchRequest: FetchRequest<Pokemon>
    var action: ((Pokemon) -> ())?
    
    var body: some View {
        LazyVStack {
            ForEach(fetchRequest.wrappedValue, id: \.name) { pokemon in
                PokemonView(pokemon)
                    .onTapGesture {
                        action?(pokemon)
                    }
                    .padding([.top], 2)
            }
        }
    }
    
    init(filter: String, action: ((Pokemon) -> ())?) {
        self.action = action
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.pokedex, ascending: true)], predicate: NSPredicate(format: "name CONTAINS[c] %@", filter))
    }
    
    init(filter: [Int16]) {
        let fetchType1 = NSPredicate(format: "type1.id IN %@", filter)
        let fetchType2 = NSPredicate(format: "type2.id IN %@ || type2.id == NULL", filter)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fetchType1, fetchType2])
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.pokedex, ascending: true)], predicate: predicate)
    }
}

struct PokemonFilteredView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonFilteredView(filter: "", action: nil)
            
            PokemonFilteredView(filter: "char", action: nil)
            
            PokemonFilteredView(filter: "char", action: nil)
                
                .preferredColorScheme(.dark)
            
            PokemonFilteredView(filter: [1,2])
        
            PokemonFilteredView(filter: [1,2])
                
                .preferredColorScheme(.dark)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
