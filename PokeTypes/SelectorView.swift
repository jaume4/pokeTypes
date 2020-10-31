//
//  SelectorView.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import SwiftUI

struct SelectorView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonType.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PokemonType>
    
    @StateObject var selection = TypeSelector()
    @State var presenting = false
    @State var selectedPokemon: String?
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 300))]) {
                    ForEach(items) { type in
                        Text(type.name)
                            .modifier(CapsuleModifier(selected: selection.selectedTypes.contains(type), id: type.id))
                            .onTapGesture{
                                selectedPokemon = nil
                                selection.select(type: type)
                            }
                    }
                }
                
                Spacer(minLength: 40)
                
                Button(action: {
                    presenting = true
                }, label: {
                    Group {
                        if let name = selectedPokemon {
                            Text(name)
                        } else {
                            Text("Seleccionar pokemon")
                        }
                    }
                    .padding()
                    .overlay(
                        Rectangle()
                            .stroke(Color(UIColor.label))
                    )
                })
                .accentColor(Color(UIColor.label))
                
                Spacer(minLength: 30)
                
                if selection.selectedTypes.isEmpty {
                    VStack {
                        Spacer()
                        Text("Selecciona los tipos\n o un Pokémon para empezar.")
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                } else {
                    TypeGridView(types: selection.allTypes)
                }
            }
            .animation(.easeInOut)
        }
        .padding([.leading, .trailing], 6)
        .sheet(isPresented: $presenting) {
            PokemonSearch(filter: "") { [weak selection] pokemon in
                presenting = false
                let transaction = Transaction()
                
                withTransaction(transaction) {
                    selectedPokemon = pokemon.name
                    selection?.removeSelection()
                    selection?.select(type: pokemon.type1)
                    if let type2 = pokemon.type2 {
                        selection?.select(type: type2)
                    }
                }
            }
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    
    static var selectedTypes: TypeSelector {
        let selector = TypeSelector()
        let types: [PokemonType] = try! PersistenceController.shared.container.viewContext.fetch(PokemonType.fetchRequest())
        selector.selectedTypes = [types[0], types[1]]
        return selector
    }
    
    static var previews: some View {
        Group {
            SelectorView()
            SelectorView()
                .preferredColorScheme(.dark)
            SelectorView(selection: selectedTypes, presenting: false, selectedPokemon: nil)
            SelectorView(selection: selectedTypes, presenting: false, selectedPokemon: nil)
                .preferredColorScheme(.dark)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
