//
//  ContentView.swift
//  Shared
//
//  Created by Andrew Li on 19/8/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        TabView {
            PocketView()
                .tabItem {
                    Label("Pocket", systemImage: "list.bullet.rectangle.portrait.fill")
                }
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
