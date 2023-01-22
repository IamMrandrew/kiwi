//
//  AddEntryView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 28/8/2022.
//

import SwiftUI

struct AddEntryView: View {
    @StateObject var vm: AddEntryViewModel
    
    init(vm: AddEntryViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack {
            CategorySelectionView(
                categories: vm.categories,
                pickCategory: vm.pickCategory,
                addEntry: vm.addEntry,
                amount: $vm.amount
            )
            .navigationTitle("Category")
            .navigationBarTitleDisplayMode(.large)
            .environmentObject(vm)
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        let previewVM = AddEntryViewModel(viewContext: previewContext)
        
        NavigationView {
            AddEntryView(vm: previewVM)
        }
    }
}
