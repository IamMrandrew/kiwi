//
//  NavigationItem.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 19/10/2022.
//

import SwiftUI

struct NavigationItem<Destination: View>: View {
    let label: String
    let icon: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(label)
                    .font(.body)
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.body)
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationItem(
            label: "History",
            icon: "clock.arrow.circlepath",
            destination: Text("Desination View")
        )
    }
}
