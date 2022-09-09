//
//  PocketView.swift
//  Kiwi
//
//  Created by Andrew Li on 20/8/2022.
//

import SwiftUI

struct PocketView: View {
    @StateObject var vm = PocketViewModel()
    @State private var isAddTransactionSheetOpen = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(formatIntoCurrency(vm.budgetLeft))
                
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
                    ToolbarItem {
                        Button {
                            isAddTransactionSheetOpen.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .animation(.default, value: vm.transactions)
//                .overlay(
//                    Button {
//                        isAddTransactionSheetOpen.toggle()
//                    } label: {
//                        Image(systemName: "chevron.up")
//                            .padding()
//                    }
//
//                )
            }
        }
        .sheet(isPresented: $isAddTransactionSheetOpen) {
            AddTransactionView()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        PocketView()
    }
}
