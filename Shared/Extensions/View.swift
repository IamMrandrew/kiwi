//
//  View.swift
//  Kiwi
//
//  Created by Andrew Li on 15/10/2022.
//

import Foundation
import SwiftUI

struct EmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
    var isEmpty: Bool
    let emptyContent: () -> EmptyContent
    
    func body(content: Content) -> some View {
        if isEmpty {
            emptyContent()
        }
        else {
            content
        }
    }
}

extension View {
    // Reference: https://betterprogramming.pub/using-swiftui-view-modifiers-to-display-empty-state-5145f220de56
    func emptyState<EmptyContent>(
        _ isEmpty: Bool,
        emptyContent: @escaping () -> EmptyContent
    ) -> some View where EmptyContent: View {
        modifier(EmptyStateViewModifier(isEmpty: isEmpty, emptyContent: emptyContent))
    }
    
    // Reference: https://betterprogramming.pub/10-helpful-tips-for-writing-cleaner-swift-and-swiftui-code-5a84e5407269
    func backgroundColor(_ color: Color) -> some View {
      return self.background(color)
    }
}
