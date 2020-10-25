//
//  TypeGridView.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import Foundation
import SwiftUI
import CoreData

enum DamageType {
    case superWeak, weak, normal, strong, superStrong, inmune
    
    var title: String {
        switch self {
        
        case .superWeak: return "Superdébil"
        case .weak: return "Débil"
        case .normal: return "Normal"
        case .strong: return "Resistente"
        case .superStrong: return "Superresistente"
        case .inmune: return "Inmune"
        }
    }
}

struct TypeGridView: View {
    
    let types: [(damage: DamageType, types: [PokemonType])]
    
    var body: some View {
        
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 300))]) {
                
                ForEach(types, id: \.damage.title) { tier in
                    
                    Section(header: Text(tier.damage.title), footer: Divider()) {
                    
                    
                        if tier.types.isEmpty {
                            Text("-")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color("0"))
                                .cornerRadius(15)
                        } else {
                            ForEach(tier.types) { type in
                                Text(type.name)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color("\(type.id)"))
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
        }
        .animation(.easeInOut)
    }
}

struct TypeGridView_Previews: PreviewProvider {
    
    static let fetchTypes: NSFetchRequest<PokemonType> = PokemonType.fetchRequest()
    static let pokemons = try! PersistenceController.shared.container.viewContext.fetch(fetchTypes)
    
    static var previews: some View {
        Group {
            ScrollView {
                TypeGridView(types: [(.normal, pokemons)])
            }
            ScrollView {
                TypeGridView(types: [(.normal, pokemons)])
            }
            .preferredColorScheme(.dark)
        }
    }
}
