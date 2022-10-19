//
//  EntryItem.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 14/9/2022.
//

import SwiftUI

struct EntryItem: View {
    var entry: EntryEntity
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(entry.category?.name ?? "")")
                        .font(.body)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    Text("$\(entry.amount, specifier: "%.2f")")
                }
                
                Spacer()
                
                Text("\(entry.category?.icon ?? "")")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .foregroundColor(.neutral.onSurface)
        }
    }
}

struct EntryItem_Previews: PreviewProvider {
    static var previews: some View {
        let previewHelper = PreviewHelper()
        let entries = previewHelper.fetchEntries()
        
        EntryItem(entry: entries.first!)
    }
}
