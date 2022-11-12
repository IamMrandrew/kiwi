//
//  CategoryItem.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 10/11/2022.
//

import SwiftUI

struct CategoryItem: View {
    let category: CategoryEntity
    let pickCategory: (CategoryEntity) -> Void
    
    var body: some View {
        Button {
            pickCategory(category)
        } label: {
            VStack(alignment: .leading) {
                Text("\(category.icon ?? "")")
                    .font(.system(size: 30))
                
                Spacer()
                    .frame(height: 8)
                
                Text("\(category.name ?? "")")
                    .font(.headline)
                
                Spacer()
                    .frame(height: 4)
                
                Text("Add entry")
                    .font(.caption)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.neutral.onSurface)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        let previewHelper = PreviewHelper()
        let categories = previewHelper.fetchCategories()
        
        CategoryItem(
            category: categories.first!,
            pickCategory: { _ in }
        )
    }
}
