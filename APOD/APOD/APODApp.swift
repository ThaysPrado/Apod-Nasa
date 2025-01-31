//
//  APODApp.swift
//  APOD
//
//  Created by Thays Prado on 29/01/25.
//

import SwiftUI

@main
struct APODApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
