//
//  CategorySelectionView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 9/11/2022.
//

import SwiftUI

struct CategorySelectionView: View {
    let categories: [CategoryEntity]
    let pickCategory: (CategoryEntity) -> Void
    
    @State private var isAddEntrySheetOpen = false
    
    var body: some View {
        List(categories) { category in
            CategoryItem(
                category: category,
                pickCategory: pickCategory
            )
        }
        .listStyle(.carousel)
        .sheet(isPresented: $isAddEntrySheetOpen) {
            // TODO: Amount value decimal pad input
        }
    }
}

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewHelper = PreviewHelper()
        let categories = previewHelper.fetchCategories()
        
        CategorySelectionView(
            categories: categories,
            pickCategory: { _ in }
        )
    }
}
