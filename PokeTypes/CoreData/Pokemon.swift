//
//  Pokemon+CoreDataProperties.swift
//
//
//  Created by Jaume on 24/10/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Pokemon)
final class Pokemon: NSManagedObject {

}

extension Pokemon {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged var pokedex: Int16
    @NSManaged var name: String
    @NSManaged var type1: PokemonType
    @NSManaged var type2: PokemonType?

}

extension Pokemon : Identifiable {
    var id: String {
        return name
    }
}
