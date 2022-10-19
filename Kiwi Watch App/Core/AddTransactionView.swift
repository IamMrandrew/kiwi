//
//  AddEntryView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 28/8/2022.
//

import SwiftUI

struct AddEntryView: View {
    @StateObject var vm: AddEntryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(vm: AddEntryViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $vm.amount)
                
                Picker(selection: $vm.pickedCategory) {
                    ForEach(vm.categories) { category in
                        Text(category.name!)
                            .tag(category)
                    }
                } label: {
                    Text("Category")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.addEntry()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        let previewVM = AddEntryViewModel(viewContext: previewContext)
        AddEntryView(vm: previewVM)
    }
}
