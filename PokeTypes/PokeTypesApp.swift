//
//  PokeTypesApp.swift
//  PokeTypes
//
//  Created by Jaume on 24/10/2020.
//

import SwiftUI

@main
struct PokeTypesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SelectorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
