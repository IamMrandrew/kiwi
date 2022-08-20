//
//  ContentViewModel.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 20/8/2022.
//

import CoreData
import Combine

class ContentViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchItems()
        PersistenceController.shared.$cloudEvent
            .sink{ newValue in
                print("PersistenceController cloudEvent property changed")
                self.fetchItems()
            }
            .store(in: &cancellables)
    }
    
    private func fetchItems() {
        do {
            let timeDataRequest: NSFetchRequest<Item> = Item.fetchRequest()
            items = try viewContext.fetch(timeDataRequest)
        } catch {
           NSLog("Handle Error!")
        }
    }
    
    func addItem() {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
                fetchItems()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }

    func deleteItems(offsets: IndexSet) {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
                fetchItems()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}
