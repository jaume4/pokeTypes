//
//  PokemonSearch.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import SwiftUI

struct PokemonSearch: View {
    
    @State var filter = ""
    var action: ((Pokemon) -> ())?
    
    var body: some View {
        ZStack() {
            if filter.isEmpty {
                Text("Introduce el nombre\npara iniciar la búsqueda.")
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView {
                    Spacer(minLength: 60)
                    PokemonFilteredView(filter: filter, action: action)
                        .animation(.spring())
                }
            }
            
            VStack {
                TextField("Búsqueda", text: $filter)
                    .padding()
                    
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.systemBackground))
                            .edgesIgnoringSafeArea(.top))
                Spacer()
            }
            
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
    
}

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
}

struct PokemonSearch_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonSearch(filter: "")
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
            PokemonSearch(filter: "char")
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
            PokemonSearch(filter: "")
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .preferredColorScheme(.dark)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
    }
}
