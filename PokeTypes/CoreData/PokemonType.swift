//
//  PokemonType+CoreDataProperties.swift
//  
//
//  Created by Jaume on 24/10/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(PokemonType)
class PokemonType: NSManagedObject {

}


extension PokemonType {

    @nonobjc class func fetchRequest() -> NSFetchRequest<PokemonType> {
        return NSFetchRequest<PokemonType>(entityName: "PokemonType")
    }

    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var innefective: Set<PokemonType>
    @NSManaged var normal: Set<PokemonType>
    @NSManaged var pokemonsType1: Set<Pokemon>
    @NSManaged var pokemonsType2: Set<Pokemon>
    @NSManaged var strong: Set<PokemonType>
    @NSManaged var weak: Set<PokemonType>

}

// MARK: Generated accessors for innefective
extension PokemonType {

    @objc(addInnefectiveObject:)
    @NSManaged func addToInnefective(_ value: PokemonType)

    @objc(removeInnefectiveObject:)
    @NSManaged func removeFromInnefective(_ value: PokemonType)

    @objc(addInnefective:)
    @NSManaged func addToInnefective(_ values: NSSet)

    @objc(removeInnefective:)
    @NSManaged func removeFromInnefective(_ values: NSSet)

}

// MARK: Generated accessors for normal
extension PokemonType {

    @objc(addNormalObject:)
    @NSManaged func addToNormal(_ value: PokemonType)

    @objc(removeNormalObject:)
    @NSManaged func removeFromNormal(_ value: PokemonType)

    @objc(addNormal:)
    @NSManaged func addToNormal(_ values: NSSet)

    @objc(removeNormal:)
    @NSManaged func removeFromNormal(_ values: NSSet)

}

// MARK: Generated accessors for pokemonsType1
extension PokemonType {

    @objc(addPokemonsType1Object:)
    @NSManaged func addToPokemonsType1(_ value: Pokemon)

    @objc(removePokemonsType1Object:)
    @NSManaged func removeFromPokemonsType1(_ value: Pokemon)

    @objc(addPokemonsType1:)
    @NSManaged func addToPokemonsType1(_ values: NSSet)

    @objc(removePokemonsType1:)
    @NSManaged func removeFromPokemonsType1(_ values: NSSet)

}

// MARK: Generated accessors for pokemonsType2
extension PokemonType {

    @objc(addPokemonsType2Object:)
    @NSManaged func addToPokemonsType2(_ value: Pokemon)

    @objc(removePokemonsType2Object:)
    @NSManaged func removeFromPokemonsType2(_ value: Pokemon)

    @objc(addPokemonsType2:)
    @NSManaged func addToPokemonsType2(_ values: NSSet)

    @objc(removePokemonsType2:)
    @NSManaged func removeFromPokemonsType2(_ values: NSSet)

}

// MARK: Generated accessors for strong
extension PokemonType {

    @objc(addStrongObject:)
    @NSManaged func addToStrong(_ value: PokemonType)

    @objc(removeStrongObject:)
    @NSManaged func removeFromStrong(_ value: PokemonType)

    @objc(addStrong:)
    @NSManaged func addToStrong(_ values: NSSet)

    @objc(removeStrong:)
    @NSManaged func removeFromStrong(_ values: NSSet)

}

// MARK: Generated accessors for weak
extension PokemonType {

    @objc(addWeakObject:)
    @NSManaged func addToWeak(_ value: PokemonType)

    @objc(removeWeakObject:)
    @NSManaged func removeFromWeak(_ value: PokemonType)

    @objc(addWeak:)
    @NSManaged func addToWeak(_ values: NSSet)

    @objc(removeWeak:)
    @NSManaged func removeFromWeak(_ values: NSSet)

}

extension PokemonType : Identifiable {

}
