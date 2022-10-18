//
//  PocketViewModel.swift
//  Kiwi
//
//  Created by Andrew Li on 20/8/2022.
//

import Foundation
import CoreData
import Combine

enum FetchMode {
    case all
    case today
    case week
    case month
}

struct Budget {
    // TODO: Retreieve budget from Core Data + CloudKit
    var total: Float = 5000.00
    var left: Float = 5000.00
    var expensesToday: Float = 0.00
    
    mutating func updateBudgetByTransactions(_ transactions: [TransactionEntity]) {
        let expenses = transactions.reduce(0) { sum, transaction in
            sum + transaction.amount
        }
        expensesToday  = transactions.filter(DateHelper.isItemTodayOnly).reduce(0) { sum, transaction in
            sum + transaction.amount
        }
        left = total - expenses
    }
}

class PocketViewModel: ObservableObject {
    @Published var transactions: [TransactionEntity] = []
    @Published var categories: [CategoryEntity] = []
    @Published var budget = Budget()
    
    // TODO: Handle case mainly for mobile view
    let fetchMode: FetchMode = .month
    
    private let viewContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        
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
    
    func fetchTransactions() {
        do {
            let transactionsRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
            let sort = NSSortDescriptor(keyPath: \TransactionEntity.entryTime, ascending: true)
            transactionsRequest.sortDescriptors = [sort]
            transactionsRequest.predicate = fetchMode != .all ? getDatePredicate(fetchMode: fetchMode) : nil
            transactions = try viewContext.fetch(transactionsRequest)
            budget.updateBudgetByTransactions(transactions)
        } catch {
            NSLog("Handle fetchTransactions() error!")
        }
    }
    
    func fetchCategories() {
        do {
            let categoriesRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            let sort = NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
            categoriesRequest.sortDescriptors = [sort]
            categories = try viewContext.fetch(categoriesRequest)
        } catch {
            NSLog("Handle fetchTransactions() error!")
        }
    }
    
    
    func deleteTransaction(sectionEntries: [TransactionEntity], offsets: IndexSet) {
        offsets.map { sectionEntries[$0] }.forEach(viewContext.delete)
        
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

/*
 * MARK: Private functions
 */

extension PocketViewModel {
    private func getDatePredicate(fetchMode: FetchMode) -> NSCompoundPredicate {
        let daysBefore = {
            switch fetchMode {
            case .today:
                return 1
            case .week:
                return 7
            case .month:
                // TODO: Handle case for month with different days
                return 30
            default:
                return 0 // Should never be excute
            }
        }()
        
        // Retrieve transactions only from N days before to today
        let endOfToday = DateHelper.getEndOfToday()
        let startOfNDayBefore = DateHelper.getStartOfNDaysBefore(days: daysBefore)
        let fromPredicate = NSPredicate(format: "entryTime >= %@", startOfNDayBefore as NSDate)
        let toPredicate = NSPredicate(format: "entryTime < %@", endOfToday as NSDate)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
    }
}
