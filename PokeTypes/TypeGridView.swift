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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 300))]) {
                
                ForEach(types, id: \.damage.title) { tier in
                    
                    Section(header:
                                Text(tier.damage.title)
                                .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body)),
                            footer: Divider()) {
                        
                        
                        if tier.types.isEmpty {
                            Text("-")
                                .font(.custom("PKMN RBYGSC", size: 14, relativeTo: .body))
                                .padding(6)
                        } else {
                            ForEach(tier.types) { type in
                                Text(type.name)
                                    .foregroundColor(.white)
                                    .modifier(CapsuleModifier(selected: false, id: type.id))
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
