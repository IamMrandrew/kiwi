//
//  ContentView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 20/8/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: vm.deleteItems)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: vm.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .animation(.default, value: vm.items)
            
            Text("Select an item")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
