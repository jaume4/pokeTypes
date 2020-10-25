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
        
        let type1StrongTo = type1?.strongTo ?? []
        let type2StrongTo = type2?.strongTo ?? []
        
        return type1StrongTo.intersection(type2StrongTo)
    }
    
    var weak: Set<PokemonType> {
        
        let type1StrongTo = type1?.strongTo ?? []
        let type2StrongTo = type2?.strongTo ?? []
        
        let type1WeakTo = type1?.weakTo ?? []
        let type2WeakTo = type2?.weakTo ?? []
        let type1Innefective = type1?.innefectiveTo ?? []
        let type2Innefective = type2?.innefectiveTo ?? []
        
        let inneffective = type1Innefective.union(type2Innefective)
        
        let weakTo = type1StrongTo.symmetricDifference(type2StrongTo).subtracting(type1WeakTo).subtracting(type2WeakTo).subtracting(inneffective)
        
        return weakTo
    }
    
    var normal: Set<PokemonType> {
        
        let type1NormalTo = type1?.normalTo ?? []
        let type2NormalTo = type2?.normalTo ?? []
        
        if type1?.id == 0 || type1 == nil {
            return type2NormalTo
        } else if type2?.id == 0 || type2 == nil {
            return type1NormalTo
        }
        
        let type1StrongTo = type1?.strongTo ?? []
        let type2StrongTo = type2?.strongTo ?? []
        let type1WeakTo = type1?.weakTo ?? []
        let type2WeakTo = type2?.weakTo ?? []
        
        let normalTo = type1NormalTo.intersection(type2NormalTo)
        let normalToMultiply1 = type1StrongTo.intersection(type2WeakTo)
        let normalToMultiply2 = type2StrongTo.intersection(type1WeakTo)
        
        let normalToMultiply = normalToMultiply1.union(normalToMultiply2)
        
        return normalTo.union(normalToMultiply)
    }
    
    var strong: Set<PokemonType> {
        let type1WeakTo = type1?.weakTo ?? []
        let type2WeakTo = type2?.weakTo ?? []
        
        let type1StrongTo = type1?.strongTo ?? []
        let type2StrongTo = type2?.strongTo ?? []
        let type1Innefective = type1?.innefectiveTo ?? []
        let type2Innefective = type2?.innefectiveTo ?? []
        
        let inneffective = type1Innefective.union(type2Innefective)
        
        let strongTo = type1WeakTo.symmetricDifference(type2WeakTo).subtracting(type1StrongTo).subtracting(type2StrongTo).subtracting(inneffective)
        
        return strongTo
    }
    
    var superStrong: Set<PokemonType> {
        let type1WeakTo = type1?.weakTo ?? []
        let type2WeakTo = type2?.weakTo ?? []
        return type1WeakTo.intersection(type2WeakTo)
    }
    
    var inmune: Set<PokemonType> {
        let type1Innefective = type1?.innefectiveTo ?? []
        let type2Innefective = type2?.innefectiveTo ?? []
        return type1Innefective.union(type2Innefective)
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
                ForEach(items.filter{ $0 != selection.type2 }) {
                    Text($0.name).tag(Optional.some($0))
                }
            }
            
            Picker("tipo2", selection: $selection.type2) {
                ForEach(items.filter{ $0 != selection.type1 }) {
                    Text($0.name).tag(Optional.some($0))
                }
            }
            
            VStack(alignment: .leading) {
                Text("Superdébil a: \(format(selection.superWeak))")
                Text("Débil a : \(format(selection.weak))")
                Text("Normal: \(format(selection.normal))")
                Text("Resistente a: \(format(selection.strong))")
                Text("Superresistente a: \(format(selection.superStrong))")
                Text("Inmune a: \(format(selection.inmune))")
            }.padding()
            
        }
    }
    
    func format(_ set: Set<PokemonType>) -> String {
        return set.isEmpty ? "-" : set.map{ $0.name }.sorted().joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
