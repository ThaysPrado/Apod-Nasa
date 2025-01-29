//
//  Apod_NasaApp.swift
//  Apod-Nasa
//
//  Created by Thays Prado on 29/01/25.
//

import SwiftUI

@main
struct Apod_NasaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
