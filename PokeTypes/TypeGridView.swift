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
        
        case .superWeak: return "Supereficaz x4"
        case .weak: return "Supereficaz x2"
        case .normal: return "Eficaz"
        case .strong: return "Poco eficaz x1/2"
        case .superStrong: return "Poco eficaz x1/4"
        case .inmune: return "Sin efecto"
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
                                Text(tier.damage.title),
                            footer:
                                LinearGradient(gradient: Gradient(colors: [.clear, Color(UIColor.label), Color(UIColor.label), Color(UIColor.label), .clear]), startPoint: .leading, endPoint: .trailing)
                                .frame(maxWidth: .infinity, maxHeight: 0.5)
                                .opacity(0.5)
                    ) {
                        
                        
                        if tier.types.isEmpty {
                            Text("-")
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
    
    static var typeSelector: TypeSelector {
        let selector = TypeSelector()
        let types: [PokemonType] = try! PersistenceController.shared.container.viewContext.fetch(PokemonType.fetchRequest())
        selector.selectedTypes = [types[0], types[1]]
        return selector
    }
    
    static var previews: some View {
        Group {
            ScrollView {
                TypeGridView(types: typeSelector.allTypes)
            }
            ScrollView {
                TypeGridView(types: typeSelector.allTypes)
            }
            .preferredColorScheme(.dark)
        }
        .font(.custom("PKMN RBYGSC", size: 12, relativeTo: .body))
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
