//
//  InputDecimalPadView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 12/11/2022.
//

import SwiftUI

struct InputDecimalPadView: View {
    @State private var amount = ""
    var body: some View {
        VStack {
            TextField("Amount", text: $amount)
            
            Spacer()
        }
    }
}

struct InputDecimalPadView_Previews: PreviewProvider {
    static var previews: some View {
        InputDecimalPadView()
    }
}
