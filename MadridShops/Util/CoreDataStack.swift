//
//  CoreDataStack.swift
//  CoreDataHelloWorld
//
//  Created by Fco. Javier Guerrero Carmona on 15/9/17.
//  Copyright © 2017 Fco. Javier Guerrero Carmona. All rights reserved.
//

import CoreData

// MARK: - Core Data stack

class CoreDataStack {
    
    public func createContainer(dbName: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("💾 \( storeDescription.description ) ")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Core Data Saving support
    
    public func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
