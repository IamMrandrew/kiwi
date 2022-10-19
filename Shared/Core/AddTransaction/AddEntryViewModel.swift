//
//  AddEntryViewModel.swift
//  Kiwi
//
//  Created by Andrew Li on 25/8/2022.
//

import Foundation
import CoreData
import Combine

class AddEntryViewModel: ObservableObject {
    @Published var amount = "0"
    @Published var pickedCategory: CategoryEntity = CategoryEntity()
    @Published var categories: [CategoryEntity] = []
    
    private let viewContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()

    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        
        fetchCategories()
    }
    
    private func fetchCategories() {
        do {
            let categoriesRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            let sort = NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
            categoriesRequest.sortDescriptors = [sort]
            categories = try viewContext.fetch(categoriesRequest)
        } catch {
           NSLog("Handle fetchEntries() error!")
        }
    }

    func addEntry() {
        let newEntry = EntryEntity(context: viewContext)
        newEntry.amount = Float(amount) ?? 0
        newEntry.entryTime = Date()
        newEntry.category = pickedCategory
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
