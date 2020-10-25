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
    
    var body: some View {
        
        ScrollView {
            
            VStack{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 300))]) {
                    ForEach(items) { type in
                        Text(type.name)
                            .foregroundColor(.white)
                            .modifier(CapsuleModifier(selected: selection.selectedTypes.contains(type), id: type.id))
                            .onTapGesture{
                                selection.select(type: type)
                            }
                    }
                }
                
                Spacer(minLength: 50)
                Divider()
                
                if selection.selectedTypes.isEmpty {
                    Text("Selecciona los tipos para empezar.")
                        .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
                } else {
                    TypeGridView(types: selection.allTypes)
                }
            }
            .animation(.easeInOut)
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
