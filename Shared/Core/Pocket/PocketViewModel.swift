//
//  PocketViewModel.swift
//  Kiwi
//
//  Created by Andrew Li on 20/8/2022.
//

import Foundation
import CoreData
import Combine

class PocketViewModel: ObservableObject {
    @Published var transactions: [TransactionEntity] = []
    @Published var categories: [CategoryEntity] = []
    @Published var budgetLeft: Float = 5000.00
    
    // TODO: Retreieve budget from Core Data + CloudKit
    let budget: Float = 5000.00
    
    private let viewContext = PersistenceController.shared.container.viewContext
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchTransactions()
        fetchCategories()
        
        PersistenceController.shared.$cloudEvent
            .sink{ newValue in
                print("PersistenceController cloudEvent property changed")
                self.fetchTransactions()
                self.fetchCategories()
            }
            .store(in: &cancellables)
    }
    
    private func fetchTransactions() {
        do {
            let transactionsRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
            let sort = NSSortDescriptor(keyPath: \TransactionEntity.entryTime, ascending: true)
            transactionsRequest.sortDescriptors = [sort]
            transactions = try viewContext.fetch(transactionsRequest)
            calculateBudget()
        } catch {
           NSLog("Handle fetchTransactions() error!")
        }
    }
    
    private func fetchCategories() {
        do {
            let categoriesRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            let sort = NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
            categoriesRequest.sortDescriptors = [sort]
            categories = try viewContext.fetch(categoriesRequest)
        } catch {
           NSLog("Handle fetchTransactions() error!")
        }
    }
    
    private func calculateBudget() {
        let expenses = transactions.reduce(0) { sum, transaction in
            sum + transaction.amount
        }
        budgetLeft = budget - expenses
    }

    func deleteTransaction(offsets: IndexSet) {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
                fetchTransactions()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}
