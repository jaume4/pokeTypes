//
//  ContentView.swift
//  PokeTypes
//
//  Created by Jaume on 24/10/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonType.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<PokemonType>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("\(item.name) type: \(item.name))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
