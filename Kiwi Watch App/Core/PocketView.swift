//
//  PocketView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 21/8/2022.
//

import SwiftUI

struct PocketView: View {
    @StateObject var vm: PocketViewModel
    @State private var isAddTransactionSheetOpen = false
    
    init(vm: PocketViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            List {
                DashboardView(
                    expenses: -vm.budget.expensesToday,
                    budgetLeft: vm.budget.left,
                    openAddTransactionSheetAction: { isAddTransactionSheetOpen.toggle() }
                )
                
                PocketSectionView(
                    "Today",
                    sectionEntries: vm.transactions.filter(DateHelper.isItemTodayOnly),
                    deleteAction: vm.deleteTransaction
                )
                
                PocketSectionView(
                    "Yesterday",
                    sectionEntries: vm.transactions.filter(DateHelper.isItemYesterdayOnly),
                    deleteAction: vm.deleteTransaction
                )
                
                NavigationItem(
                    label: "History",
                    icon: "clock.arrow.circlepath",
                    destination: Text("History")
                )
            }
            .animation(.default, value: vm.transactions)
        }
        .sheet(isPresented: $isAddTransactionSheetOpen) {
            AddTransactionView()
        }
    }
}

struct DashboardView: View {
    let expenses: Float
    let budgetLeft: Float
    let openAddTransactionSheetAction: () -> Void
    
    var body: some View {
        BalanceCard(
            expenses: expenses,
            budgetLeft: budgetLeft
        )
            
        ActionButton(buttonAction: openAddTransactionSheetAction)
            .listItemTint(.accent.primary)
    }
}

struct PocketSectionView: View {
    let title: String
    let sectionEntries: [TransactionEntity]
    let deleteAction: ([TransactionEntity], IndexSet) -> Void
    
    init(
        _ title: String,
        sectionEntries: [TransactionEntity],
        deleteAction: @escaping ([TransactionEntity], IndexSet) -> Void
    ) {
        self.title = title
        self.sectionEntries = sectionEntries
        self.deleteAction = deleteAction
    }
    
        
    var body: some View {
        Section(title) {
            ForEach(sectionEntries) { transaction in
                TransactionItem(transaction: transaction)
                    .listRowInsets(EdgeInsets())
            }
            .onDelete { offsets in
                deleteAction(sectionEntries, offsets)
            }
        }
        .textCase(nil)
        .emptyState(sectionEntries.isEmpty) { EmptyView() }
    }
}

struct PocketView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        let previewVM = PocketViewModel(viewContext: previewContext)
        PocketView(vm: previewVM)
    }
}

