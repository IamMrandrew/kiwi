//
//  AddTransactionView.swift
//  Kiwi (iOS)
//
//  Created by Andrew Li on 25/8/2022.
//

import SwiftUI

struct AddTransactionView: View {
    @StateObject var vm = AddTransactionViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $vm.amount)
#if os(iOS)
                    .keyboardType(.decimalPad)
#endif
                
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
                        vm.addTransaction()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
