//
//  CategorySelectionView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 9/11/2022.
//

import SwiftUI

struct CategorySelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    let categories: [CategoryEntity]
    let pickCategory: (CategoryEntity) -> Void
    let addEntry: () -> Void
    @Binding var amount: String
    
    @State private var isAddEntrySheetOpen = false
    
    var body: some View {
        List(categories) { category in
            CategoryItem(
                category: category,
                pickCategory: pickCategory,
                action: presentInputController
            )
//            TODO: Amount value decimal pad input
//            .onTapGesture {
//                isAddEntrySheetOpen.toggle()
//            }
        }
        .listStyle(.carousel)
        .sheet(isPresented: $isAddEntrySheetOpen) {
            // TODO: Amount value decimal pad input
            InputDecimalPadView()
        }
    }
    
    private func presentInputController() {
         presentInputController(withSuggestions: []) { result in
             presentationMode.wrappedValue.dismiss()
             // handle result from input controller
             guard !result.isEmpty else { return }
             amount = result
             addEntry()
         }
     }
}

extension View {
    typealias StringCompletion = (String) -> Void
    
    func presentInputController(withSuggestions suggestions: [String], completion: @escaping StringCompletion) {
        WKExtension.shared()
            .visibleInterfaceController?
            .presentTextInputController(withSuggestions: suggestions,
                                        allowedInputMode: .plain) { result in
                
                guard let result = result as? [String], let firstElement = result.first else {
                    completion("")
                    return
                }
                
                completion(firstElement)
            }
    }
}

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let previewHelper = PreviewHelper()
        let categories = previewHelper.fetchCategories()
        
        CategorySelectionView(
            categories: categories,
            pickCategory: { _ in },
            addEntry: {},
            amount: .constant("0")
        )
    }
}
