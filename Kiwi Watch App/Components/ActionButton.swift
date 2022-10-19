//
//  ActionButton.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 18/10/2022.
//

import SwiftUI

struct ActionButton: View {
    let label: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(label)
                .font(.label.actionButton)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(label: "Add entry", buttonAction: {})
    }
}
