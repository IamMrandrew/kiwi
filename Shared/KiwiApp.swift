//
//  KiwiApp.swift
//  Shared
//
//  Created by Andrew Li on 19/8/2022.
//

import SwiftUI

@main
struct KiwiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
