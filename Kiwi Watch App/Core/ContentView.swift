//
//  ContentView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 20/8/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ContentViewModel
    
    init(vm: ContentViewModel = .init()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        PocketView()
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
        let previewContext = PersistenceController.preview.container.viewContext
        let previewVM = ContentViewModel(viewContext: previewContext)
        ContentView(vm: previewVM)
    }
}
