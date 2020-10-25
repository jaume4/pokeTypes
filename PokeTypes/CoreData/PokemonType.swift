//
//  PokemonType+CoreDataProperties.swift
//
//
//  Created by Jaume on 25/10/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(PokemonType)
final class PokemonType: NSManagedObject {

}


extension PokemonType {

    @nonobjc class func fetchRequest() -> NSFetchRequest<PokemonType> {
        return NSFetchRequest<PokemonType>(entityName: "PokemonType")
    }

    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var innefectiveAgainst: Set<PokemonType>
    @NSManaged var innefectiveTo: Set<PokemonType>
    @NSManaged var normalAgainst: Set<PokemonType>
    @NSManaged var normalTo: Set<PokemonType>
    @NSManaged var pokemonsType1: Set<PokemonType>
    @NSManaged var pokemonsType2: Set<PokemonType>
    @NSManaged var strongAgainst: Set<PokemonType>
    @NSManaged var strongTo: Set<PokemonType>
    @NSManaged var weakAgainst: Set<PokemonType>
    @NSManaged var weakTo: Set<PokemonType>

}

// MARK: Generated accessors for innefectiveAgainst
extension PokemonType {

    @objc(addInnefectiveAgainstObject:)
    @NSManaged func addToInnefectiveAgainst(_ value: PokemonType)

    @objc(removeInnefectiveAgainstObject:)
    @NSManaged func removeFromInnefectiveAgainst(_ value: PokemonType)

    @objc(addInnefectiveAgainst:)
    @NSManaged func addToInnefectiveAgainst(_ values: Set<PokemonType>)

    @objc(removeInnefectiveAgainst:)
    @NSManaged func removeFromInnefectiveAgainst(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for innefectiveTo
extension PokemonType {

    @objc(addInnefectiveToObject:)
    @NSManaged func addToInnefectiveTo(_ value: PokemonType)

    @objc(removeInnefectiveToObject:)
    @NSManaged func removeFromInnefectiveTo(_ value: PokemonType)

    @objc(addInnefectiveTo:)
    @NSManaged func addToInnefectiveTo(_ values: Set<PokemonType>)

    @objc(removeInnefectiveTo:)
    @NSManaged func removeFromInnefectiveTo(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for normalAgainst
extension PokemonType {

    @objc(addNormalAgainstObject:)
    @NSManaged func addToNormalAgainst(_ value: PokemonType)

    @objc(removeNormalAgainstObject:)
    @NSManaged func removeFromNormalAgainst(_ value: PokemonType)

    @objc(addNormalAgainst:)
    @NSManaged func addToNormalAgainst(_ values: Set<PokemonType>)

    @objc(removeNormalAgainst:)
    @NSManaged func removeFromNormalAgainst(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for normalTo
extension PokemonType {

    @objc(addNormalToObject:)
    @NSManaged func addToNormalTo(_ value: PokemonType)

    @objc(removeNormalToObject:)
    @NSManaged func removeFromNormalTo(_ value: PokemonType)

    @objc(addNormalTo:)
    @NSManaged func addToNormalTo(_ values: Set<PokemonType>)

    @objc(removeNormalTo:)
    @NSManaged func removeFromNormalTo(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for pokemonsType1
extension PokemonType {

    @objc(addPokemonsType1Object:)
    @NSManaged func addToPokemonsType1(_ value: Pokemon)

    @objc(removePokemonsType1Object:)
    @NSManaged func removeFromPokemonsType1(_ value: Pokemon)

    @objc(addPokemonsType1:)
    @NSManaged func addToPokemonsType1(_ values: Set<PokemonType>)

    @objc(removePokemonsType1:)
    @NSManaged func removeFromPokemonsType1(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for pokemonsType2
extension PokemonType {

    @objc(addPokemonsType2Object:)
    @NSManaged func addToPokemonsType2(_ value: Pokemon)

    @objc(removePokemonsType2Object:)
    @NSManaged func removeFromPokemonsType2(_ value: Pokemon)

    @objc(addPokemonsType2:)
    @NSManaged func addToPokemonsType2(_ values: Set<PokemonType>)

    @objc(removePokemonsType2:)
    @NSManaged func removeFromPokemonsType2(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for strongAgainst
extension PokemonType {

    @objc(addStrongAgainstObject:)
    @NSManaged func addToStrongAgainst(_ value: PokemonType)

    @objc(removeStrongAgainstObject:)
    @NSManaged func removeFromStrongAgainst(_ value: PokemonType)

    @objc(addStrongAgainst:)
    @NSManaged func addToStrongAgainst(_ values: Set<PokemonType>)

    @objc(removeStrongAgainst:)
    @NSManaged func removeFromStrongAgainst(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for strongTo
extension PokemonType {

    @objc(addStrongToObject:)
    @NSManaged func addToStrongTo(_ value: PokemonType)

    @objc(removeStrongToObject:)
    @NSManaged func removeFromStrongTo(_ value: PokemonType)

    @objc(addStrongTo:)
    @NSManaged func addToStrongTo(_ values: Set<PokemonType>)

    @objc(removeStrongTo:)
    @NSManaged func removeFromStrongTo(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for weakAgainst
extension PokemonType {

    @objc(addWeakAgainstObject:)
    @NSManaged func addToWeakAgainst(_ value: PokemonType)

    @objc(removeWeakAgainstObject:)
    @NSManaged func removeFromWeakAgainst(_ value: PokemonType)

    @objc(addWeakAgainst:)
    @NSManaged func addToWeakAgainst(_ values: Set<PokemonType>)

    @objc(removeWeakAgainst:)
    @NSManaged func removeFromWeakAgainst(_ values: Set<PokemonType>)

}

// MARK: Generated accessors for weakTo
extension PokemonType {

    @objc(addWeakToObject:)
    @NSManaged func addToWeakTo(_ value: PokemonType)

    @objc(removeWeakToObject:)
    @NSManaged func removeFromWeakTo(_ value: PokemonType)

    @objc(addWeakTo:)
    @NSManaged func addToWeakTo(_ values: Set<PokemonType>)

    @objc(removeWeakTo:)
    @NSManaged func removeFromWeakTo(_ values: Set<PokemonType>)

}

extension PokemonType : Identifiable {

}

extension PokemonType: Comparable {
    static func < (lhs: PokemonType, rhs: PokemonType) -> Bool {
        return lhs.name < rhs.name
    }
    
    
}
