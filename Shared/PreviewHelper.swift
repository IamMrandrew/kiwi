//
//  PreviewHelper.swift
//  Kiwi
//
//  Created by Andrew Li on 9/10/2022.
//

import Foundation
import CoreData

class PreviewHelper {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.preview.container.viewContext) {
        self.viewContext = viewContext
    }
    
    // Almost duplicate as functions in other ViewModels
    func initForNewUser() {
        // Init setting
        _ = SettingEntity(context: viewContext)
        
        // Init default categories and Dummpy entry items
        var categoryEntities = [CategoryEntity]()
        for category in DefaultValues.categories {
            let newCategory = CategoryEntity(context: viewContext)
            newCategory.name = category.0
            newCategory.icon = category.1
            categoryEntities.append(newCategory)
        }
        
        for i in 0..<5 {
            let newEntry = EntryEntity(context: viewContext)
            newEntry.amount = 10.42 * Float(i + 1)
            newEntry.entryTime = Date()
            newEntry.category = categoryEntities[i]
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchEntries() -> [EntryEntity] {
        let entriesRequest: NSFetchRequest<EntryEntity> = EntryEntity.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \EntryEntity.entryTime, ascending: true)
        entriesRequest.sortDescriptors = [sort]
        return try! viewContext.fetch(entriesRequest)
    }
    
    func fetchCategories() -> [CategoryEntity] {
        let categoriesRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
        categoriesRequest.sortDescriptors = [sort]
        return try! viewContext.fetch(categoriesRequest)
    }
}
