//
//  PocketView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 21/8/2022.
//

import SwiftUI

struct PocketView: View {
    @StateObject var vm: PocketViewModel
    @State private var isAddEntrySheetOpen = false
    
    init(vm: PocketViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            List {
                DashboardView(
                    expenses: -vm.budget.expensesToday,
                    budgetLeft: vm.budget.left,
                    openAddEntrySheetAction: { isAddEntrySheetOpen.toggle() }
                )
                
                PocketSectionView(
                    "Today",
                    sectionEntries: vm.entries.filter(DateHelper.isItemTodayOnly),
                    deleteAction: vm.deleteEntry
                )
                
                PocketSectionView(
                    "Yesterday",
                    sectionEntries: vm.entries.filter(DateHelper.isItemYesterdayOnly),
                    deleteAction: vm.deleteEntry
                )
                
                NavigationItem(
                    label: "History",
                    icon: "clock.arrow.circlepath",
                    destination: Text("History")
                )
            }
            .animation(.default, value: vm.entries)
        }
        .sheet(isPresented: $isAddEntrySheetOpen) {
            AddEntryView()
        }
    }
}

struct DashboardView: View {
    let expenses: Float
    let budgetLeft: Float
    let openAddEntrySheetAction: () -> Void
    
    var body: some View {
        BalanceCard(
            expenses: expenses,
            budgetLeft: budgetLeft
        )
        
        ActionButton(
            label: "Add entry",
            buttonAction: openAddEntrySheetAction
        )
        .listItemTint(.accent.primary)
    }
}

struct PocketSectionView: View {
    let title: String
    let sectionEntries: [EntryEntity]
    let deleteAction: ([EntryEntity], IndexSet) -> Void
    
    init(
        _ title: String,
        sectionEntries: [EntryEntity],
        deleteAction: @escaping ([EntryEntity], IndexSet) -> Void
    ) {
        self.title = title
        self.sectionEntries = sectionEntries
        self.deleteAction = deleteAction
    }
    
        
    var body: some View {
        Section(title) {
            ForEach(sectionEntries) { entry in
                EntryItem(entry: entry)
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

