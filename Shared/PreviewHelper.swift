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
        
        // Init default categories and Dummpy transaction items
        let defaultCategories = ["Food", "Transport", "Subscriptions", "Purchases", "Leisure", "Other"]
        var categoryEntities = [CategoryEntity]()
        for category in defaultCategories {
            let newCategory = CategoryEntity(context: viewContext)
            newCategory.name = category
            categoryEntities.append(newCategory)
        }
        
        for i in 0..<5 {
            let newTransaction = TransactionEntity(context: viewContext)
            newTransaction.amount = 10.42 * Float(i + 1)
            newTransaction.entryTime = Date()
            newTransaction.category = categoryEntities.first
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
    
    func fetchTransactions() -> [TransactionEntity] {
        let transactionsRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \TransactionEntity.entryTime, ascending: true)
        transactionsRequest.sortDescriptors = [sort]
        return try! viewContext.fetch(transactionsRequest)
    }
}
