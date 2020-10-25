//
//  ContentView.swift
//  PokeTypes
//
//  Created by Jaume on 24/10/2020.
//

import SwiftUI
import CoreData

class Model: ObservableObject {
    
    @Published var type1: PokemonType?
    @Published var type2: PokemonType?
    
    var superWeak: Set<PokemonType> {
        let type1Weak = type1?.weak ?? []
        let type2Weak = type2?.weak ?? []
        print("superwweak")
        return type1Weak.intersection(type2Weak)
    }
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonType.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PokemonType>
    
    @StateObject var selection = Model()

    var body: some View {
        
        VStack {
            
            Picker("tipo1", selection: $selection.type1) {
                ForEach(items) {
                    Text($0.name).tag(Optional.some($0))
                }
            }
            
            Picker("tipo2", selection: $selection.type2) {
                ForEach(items) {
                    Text($0.name).tag(Optional.some($0))
                }
            }
            
            Text(selection.superWeak.map{ $0.name }.joined())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
