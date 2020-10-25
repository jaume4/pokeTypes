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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 300))]) {
                    ForEach(items) { type in
                        Text(type.name)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(selection.selectedTypes.contains(type) ? Color.black : Color.red)
                            .cornerRadius(15)
                            .onTapGesture{
                                selection.select(type: type)
                            }
                    }
                }
                
                Divider()
                
                if selection.selectedTypes.isEmpty {
                    Spacer(minLength: 50)
                    Text("Selecciona tipos para empezar.")
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
        SelectorView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
