//
//  PocketView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 21/8/2022.
//

import SwiftUI

struct PocketView: View {
    @StateObject var vm = PocketViewModel()
    @State private var isAddTransactionSheetOpen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.transactions) { transaction in
                    HStack {
                        Text("\(transaction.amount, specifier: "%.2f")")
                        
                        Text("\(transaction.entryTime!, formatter: transactionDateFormatter)")
                        
                        Text("\(transaction.category?.name ?? "")")
                    }
                }
                .onDelete(perform: vm.deleteTransaction)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button {
                        isAddTransactionSheetOpen.toggle()
                    } label: {
                        
                        Label("Add Transaction", systemImage: "plus")
                    }
                }
            }
            .animation(.default, value: vm.transactions)
        }
        .sheet(isPresented: $isAddTransactionSheetOpen) {
            AddTransactionView()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        PocketView()
            .environmentObject(AddTransactionViewModel())
    }
}
