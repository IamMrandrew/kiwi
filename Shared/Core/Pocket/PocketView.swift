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
    @State private var isAddEntrySheetOpen = false
    
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
                        Text(formatIntoCurrency(vm.budget.left))
                            .font(.system(size: 48, weight: .semibold))
                        
                        Spacer()
                            .frame(height: 24)
                        
                        // Workaround only, before budget model is implemented
                        HStack() {
                            Text("-\(formatIntoCurrency(vm.budget.total - vm.budget.left))")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("+\(formatIntoCurrency(vm.budget.total - vm.budget.total))")
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
                    ForEach(vm.entries) { entry in
                        EntryItem(entry: entry)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete { offsets in
                        vm.deleteEntry(
                            sectionEntries: vm.entries,
                            offsets: offsets
                        )
                    }
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem {
                        Button {
                            isAddEntrySheetOpen.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .animation(.default, value: vm.entries)
//                .overlay(
//                    Button {
//                        isAddEntrySheetOpen.toggle()
//                    } label: {
//                        Image(systemName: "chevron.up")
//                            .padding()
//                    }
//
//                )
            }
        }
        .sheet(isPresented: $isAddEntrySheetOpen) {
            AddEntryView()
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        PocketView()
    }
}
