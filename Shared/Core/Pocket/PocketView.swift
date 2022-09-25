//
//  PocketView.swift
//  Kiwi
//
//  Created by Andrew Li on 20/8/2022.
//

import SwiftUI

enum DisplayMode: String, CaseIterable, Identifiable {
    case day, week
    
    var id: Self { self }
}

struct PocketView: View {
    @StateObject var vm = PocketViewModel()
    @State private var isAddTransactionSheetOpen = false
    
    // Workaround before implementing in vm
    @State private var displayMode: DisplayMode = .day
    
    var body: some View {
        NavigationView {
            VStack {
                // Header balance left
                Group {
                    Spacer()
                        .frame(height: 40)
                    
                    VStack {
                        Text(formatIntoCurrency(vm.budgetLeft))
                            .font(.system(size: 48, weight: .semibold))
                        
                        Spacer()
                            .frame(height: 24)
                        
                        // Workaround only, before budget model is implemented
                        HStack() {
                            Text("-\(formatIntoCurrency(vm.budget - vm.budgetLeft))")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("+\(formatIntoCurrency(vm.budget - vm.budget))")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.green)
                        }
                    }
                    .fixedSize()
                    
                    Spacer()
                        .frame(height: 48)
                }
                
                Picker("Test", selection: $displayMode) {
                    ForEach(DisplayMode.allCases) { mode in
                        Text(mode.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 180)
                
                Spacer()
                    .frame(height: 30)
                
                List {
                    ForEach(vm.transactions) { transaction in
                        TransactionItem(transaction: transaction)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: vm.deleteTransaction)
                }
                .listStyle(PlainListStyle())
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
