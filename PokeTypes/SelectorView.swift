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
                
                if let name = selectedPokemon {
                    Text(name)
                        .font(.custom("PKMN RBYGSC", size: 16, relativeTo: .body))
                        .padding(.all, 10)
                        .overlay(
                            Rectangle()
                                .stroke(Color(UIColor.label))
                        )
                        .padding(.top, 10)
                    
                }
                
                Spacer(minLength: 50)
                
                if selection.selectedTypes.isEmpty {
                    VStack {
                        Text("Selecciona los tipos para empezar")
                            .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
                        Spacer(minLength: 20)
                        Button(action: {
                            presenting = true
                        }, label: {
                            Text("o selecciona un pokemon.")
                                .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
                        })
                    }
                } else {
                    TypeGridView(types: selection.allTypes)
                    Button(action: {
                        presenting = true
                    }, label: {
                        Text("Seleccionar pokemon.")
                            .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
                    })
                }
            }
            .animation(.easeInOut)
        }
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
    static var previews: some View {
        Group {
            SelectorView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            SelectorView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
