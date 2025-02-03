//
//  PersistenceController.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import CoreData

final class PersistenceController {
    let container: NSPersistentContainer
    
    init(modelName: String, inMemory: Bool = false) {
        if inMemory {
            container = NSPersistentContainer(name: modelName)
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        } else {
            container = NSPersistentContainer(name: modelName)
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}
