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
        
        let dexJSON = Bundle.main.url(forResource: "pokedex", withExtension: "json")!
        let multiplierJson = Bundle.main.url(forResource: "damage multiplier", withExtension: "json")!
        let typeNamesJson = Bundle.main.url(forResource: "type names", withExtension: "json")!
        
        let dex = try! decoder.decode(Pokedex.self, from: try! Data(contentsOf: dexJSON))
        let savedMultipliers = try! decoder.decode([MultiplierElement].self, from: try! Data(contentsOf: multiplierJson))
        let savedTypeNames = try! decoder.decode([TypeName].self, from: try! Data(contentsOf: typeNamesJson))
        
        let spaTypes = savedTypeNames.filter{ $0.localLanguageID == 7 }
        let engTypes = savedTypeNames.filter{ $0.localLanguageID == 9 }
        
        pokemons = dex.pokemons.map{ pokemonInfo -> Pokemon in
            let pokemon = Pokemon(context: persistence.container.viewContext)
            pokemon.name = pokemonInfo.name
            pokemon.pokedex = pokemonInfo.num
            return pokemon
        }
        
        types = spaTypes.map { typeInfo -> PokemonType in
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
        
        pokemons.forEach { pokemon in
            let dexPokemon = dex.pokemons.first(where: {$0.name == pokemon.name})!
            let type1ID = engTypes.first(where: { $0.name == dexPokemon.type1 })!.typeID
            let type1 = types.first(where: { $0.id == type1ID })!
            pokemon.type1 = type1
            
            if let pokemonType2 = dexPokemon.type2 {
                let type2ID = engTypes.first(where: { $0.name == pokemonType2 })!.typeID
                let type2 = types.first(where: { $0.id == type2ID })!
                pokemon.type2 = type2
            }
            
        }
        
        try! persistence.container.viewContext.save()
        
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

struct TypeName: Codable {
    let typeID, localLanguageID: Int16
    let name: String

    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case localLanguageID = "local_language_id"
        case name
    }
}

struct Pokedex: Decodable {
    
    let pokemons: [DecodedPokemon]
    
    init(from decoder: Decoder) throws {
        let pokemonsContainer = try decoder.container(keyedBy: AnyKey.self)
        var pokemons: [DecodedPokemon] = []
        
        try pokemonsContainer.allKeys.forEach { key in
            let propertiesContainer = try pokemonsContainer.nestedContainer(keyedBy: AnyKey.self, forKey: key)
            let name = try propertiesContainer.decode(String.self, forKey: .init(knownKey: "name"))
            let num = try propertiesContainer.decode(Int16.self, forKey: .init(knownKey: "num"))
            
            guard num > 0 else { return }
            
            
            let typesArray = try propertiesContainer.decode([String].self, forKey: .init(knownKey: "types"))
            
            if typesArray.count == 1 {
                pokemons.append(DecodedPokemon(name: name, num: num, type1: typesArray[0], type2: nil))
            } else {
                pokemons.append(DecodedPokemon(name: name, num: num, type1: typesArray[0], type2: typesArray[1]))
            }
            
        }
        
        self.pokemons = pokemons
    }
}

struct DecodedPokemon {
    
    let name: String
    let num: Int16
    let type1: String
    let type2: String?
    
}

struct AnyKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init(knownKey: String) {
        stringValue = knownKey
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}
