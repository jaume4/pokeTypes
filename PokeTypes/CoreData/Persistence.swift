//
//  Persistence.swift
//  PokeTypes
//
//  Created by Jaume on 24/10/2020.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    
    @AppStorage("generatedDatabase") var createdDatabase: Bool = false

    let container: NSPersistentContainer

    init() {
        
        container = NSPersistentContainer(name: "PokeTypes")
//        container.persistentStoreDescriptions.first!.url = Bundle.main.url(forResource: "PokeTypes", withExtension: "sqlite")!
//        container.persistentStoreDescriptions.first!.isReadOnly = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        if !createdDatabase {
            _ = Loader(persistence: self)
            createdDatabase = true
        }
    }
}
