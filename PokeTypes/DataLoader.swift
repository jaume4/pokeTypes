//
//  DataLoader.swift
//  PokeTypes
//
//  Created by Jaume on 24/10/2020.
//

import Foundation

struct Loader {
    
    let decoder = JSONDecoder()
    var pokemons: [Pokemon]
    var types: [PokemonType]
    
    init(persistence: PersistenceController) {
        let multiplierJson = Bundle.main.url(forResource: "damage multiplier", withExtension: "json")!
        let pokemonTypesJson = Bundle.main.url(forResource: "pokemon types", withExtension: "json")!
        let pokemonsJson = Bundle.main.url(forResource: "pokemons", withExtension: "json")!
        let typeNamesJson = Bundle.main.url(forResource: "type names", withExtension: "json")!
        
        let savedMultipliers = try! decoder.decode([MultiplierElement].self, from: try! Data(contentsOf: multiplierJson))
        let savedPokemonTypes = try! decoder.decode([PokemonInfoType].self, from: try! Data(contentsOf: pokemonTypesJson))
        let savedPokemons = try! decoder.decode([PokemonElement].self, from: try! Data(contentsOf: pokemonsJson))
        let savedTypeNames = try! decoder.decode([TypeName].self, from: try! Data(contentsOf: typeNamesJson)).filter{ $0.localLanguageID == 7 }
        
        
        pokemons = savedPokemons.map { pokemonInfo -> Pokemon in
            let pokemon = Pokemon(context: persistence.container.viewContext)
            pokemon.name = pokemonInfo.identifier.capitalized
            pokemon.id = pokemonInfo.id
            return pokemon
        }
        
        types = savedTypeNames.map { typeInfo -> PokemonType in
            let type = PokemonType(context: persistence.container.viewContext)
            type.id = typeInfo.typeID
            type.name = typeInfo.name
            return type
        }
        
        savedMultipliers.forEach { multiplierInfo in
            let damageType = types.first(where: {$0.id == multiplierInfo.damageTypeID})!
            let targetType = types.first(where: {$0.id == multiplierInfo.targetTypeID})!
            
            switch multiplierInfo.damageFactor {
            case 0:
                damageType.addToInnefective(targetType)
            case 50:
                damageType.addToWeak(targetType)
            case 100:
                damageType.addToNormal(targetType)
            case 200:
                damageType.addToStrong(targetType)
            default: fatalError("Unexpected factor")
            }
            
        }
        
        savedPokemonTypes.forEach { pokemonType in
            
            guard let pokemon = pokemons.first(where: {$0.id == pokemonType.pokemonID}) else { return }
            let type = types.first(where: {$0.id == pokemonType.typeID})!
            
            if pokemonType.slot == 1 {
                pokemon.type1 = type
            } else {
                pokemon.type2 = type
            }
        }
        
        
        try! persistence.container.viewContext.save()
        
        print("hola")
        
    }
    
}

struct MultiplierElement: Codable {
    let damageTypeID, targetTypeID, damageFactor: Int16

    enum CodingKeys: String, CodingKey {
        case damageTypeID = "damage_type_id"
        case targetTypeID = "target_type_id"
        case damageFactor = "damage_factor"
    }
}

struct PokemonInfoType: Codable {
    let pokemonID, typeID, slot: Int16

    enum CodingKeys: String, CodingKey {
        case pokemonID = "pokemon_id"
        case typeID = "type_id"
        case slot
    }
}

struct PokemonElement: Codable {
    let id: Int16
    let identifier: String
    let generationID: Int
    let colorID: Int
    let captureRate: Int
    let isBaby, hatchCounter: Int
    let formsSwitchable, isLegendary, isMythical: Int

    enum CodingKeys: String, CodingKey {
        case id, identifier
        case generationID = "generation_id"
        case colorID = "color_id"

        case captureRate = "capture_rate"
        
        case isBaby = "is_baby"
        case hatchCounter = "hatch_counter"
        
        case formsSwitchable = "forms_switchable"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
    }
}

struct TypeName: Codable {
    let typeID, localLanguageID: Int16
    let name: String

    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case localLanguageID = "local_language_id"
        case name
    }
}
