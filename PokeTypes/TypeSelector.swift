//
//  TypeSelector.swift
//  PokeTypes
//
//  Created by Jaume on 25/10/2020.
//

import SwiftUI

struct PokemonTierType: Hashable {
    let name: String
    let id: Int16
}

struct PokemonTier: Hashable, Identifiable {
    let damage: DamageType
    let types: [PokemonTierType]
    
    var id: Int {
        hashValue
    }

}

final class TypeSelector: ObservableObject {
    
    @Published var selectedName: String?
    @Published var selectedTypes: ContiguousArray<PokemonType> = []
    @Published var tiers: [PokemonTier] = []
    @Published var selectedTier: PokemonTier?
    
    var type1: PokemonType? {
        selectedTypes.first
    }
    
    var type2: PokemonType? {
        selectedTypes.count > 1 ? selectedTypes.last : nil
    }
    
    func select(type: PokemonType) {

        defer {
            tiers = [
                PokemonTier(damage: .superWeak, types: Array(superWeak).sorted().map { PokemonTierType(name: $0.name, id: $0.id) }),
                PokemonTier(damage: .weak, types: Array(weak).sorted().map { PokemonTierType(name: $0.name, id: $0.id) }),
                PokemonTier(damage: .normal, types: Array(normal).sorted().map { PokemonTierType(name: $0.name, id: $0.id) }),
                PokemonTier(damage: .strong, types: Array(strong).sorted().map { PokemonTierType(name: $0.name, id: $0.id) }),
                PokemonTier(damage: .superStrong, types: Array(superStrong).sorted().map { PokemonTierType(name: $0.name, id: $0.id) }),
                PokemonTier(damage: .inmune, types: Array(inmune).sorted().map { PokemonTierType(name: $0.name, id: $0.id) })
            ]
            
            print(tiers.map{ $0.types.map{ $0.name } })
        }
        
        if let index = selectedTypes.firstIndex(where: {$0 == type}) { //Remove if already selected
            selectedTypes.remove(at: index)
            return
        }
        
        if selectedTypes.count > 1 {
            selectedTypes.removeFirst()
        }
        selectedTypes.append(type)
    }
    
    func removeSelection() {
        selectedTypes.removeAll()
        tiers = []
    }
    
    private var superWeak: Set<PokemonType> {
        
        let type1StrongTo = type1?.strongTo ?? []
        let type2StrongTo = type2?.strongTo ?? []
        
        return type1StrongTo.intersection(type2StrongTo)
    }
    
    private var weak: Set<PokemonType> {
        
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
    
    private var normal: Set<PokemonType> {
        
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
    
    private var strong: Set<PokemonType> {
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
    
    private var superStrong: Set<PokemonType> {
        let type1WeakTo = type1?.weakTo ?? []
        let type2WeakTo = type2?.weakTo ?? []
        return type1WeakTo.intersection(type2WeakTo)
    }
    
    private var inmune: Set<PokemonType> {
        let type1Innefective = type1?.innefectiveTo ?? []
        let type2Innefective = type2?.innefectiveTo ?? []
        return type1Innefective.union(type2Innefective)
    }
    
}
