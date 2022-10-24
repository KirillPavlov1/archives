//
//  create_archivesApp.swift
//  create archives
//
//  Created by Кирилл on 24.10.2022.
//

import SwiftUI

@main
struct create_archivesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
