//
//  InputDecimalPadViewModel.swift
//  Kiwi
//
//  Created by Andrew Li on 11/1/2023.
//

import Foundation

class InputDecimalPadViewModel: ObservableObject {
    @Published var amount: String = ""
    
    func onButtonPress(_ digit: String) {
        switch digit {
        case "0"..."9":
            amount += digit
        case ".":
            amount += digit
        case "D":
            amount.removeLast()
        default:
            amount += digit
        }
    }
}
