//
//  CategorySelectionView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 9/11/2022.
//

import SwiftUI

struct CategorySelectionView: View {
    @EnvironmentObject var vm: AddEntryViewModel
    @Environment(\.dismiss) private var dismiss
    
    let categories: [CategoryEntity]
    let pickCategory: (CategoryEntity) -> Void
    let addEntry: () -> Void
    
    @Binding var amount: String
    
    @State private var isAddEntrySheetOpen = false
    @State var isDoneAction = false
    
    var body: some View {
        List(categories) { category in
            CategoryItem(
                category: category,
                pickCategory: pickCategory,
                action: toggleInputDecimalPad
            )
        }
        .listStyle(.carousel)
        .sheet(
            isPresented: $isAddEntrySheetOpen,
            onDismiss: { if isDoneAction { dismiss() } }
        ) {
            InputDecimalPadView(amount: $amount,
                                addEntry: addEntry,
                                isDoneAction: $isDoneAction
            )
            .environmentObject(vm)
        }
    }
    
    private func toggleInputDecimalPad() {
        isAddEntrySheetOpen.toggle()
    }
    
//    private func presentInputController() {
//         presentInputController(withSuggestions: []) { result in
//             presentationMode.wrappedValue.dismiss()
//             // handle result from input controller
//             guard !result.isEmpty else { return }
//             amount = result
//             addEntry()
//         }
//     }
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
        .environmentObject(AddEntryViewModel())
    }
}
