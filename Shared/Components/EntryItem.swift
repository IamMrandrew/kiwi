//
//  EntryItem.swift
//  Kiwi
//
//  Created by Andrew Li on 10/9/2022.
//

import SwiftUI

struct EntryItem: View {
    var entry: EntryEntity
    
    var body: some View {
        VStack {
            HStack {
                Text("\(entry.category?.icon ?? "")")
                
                Spacer()
                    .frame(width: 30)
                
                VStack(alignment: .leading) {
                    Text("\(entry.category?.name ?? "")")
                    
                    Spacer()
                        .frame(height: 4)
                    
                    Text("\(entry.entryTime!, formatter: entryDateFormatter)")
                }
                
                Spacer()
                
                Text("$\(entry.amount, specifier: "%.2f")")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color("Surface"))
            .cornerRadius(8)
        }
    }
}

//struct EntryItem_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryItem()
//    }
//}
