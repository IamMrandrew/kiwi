//
//  Formatter.swift
//  Kiwi
//
//  Created by Andrew Li on 21/8/2022.
//

import Foundation

let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

func formatIntoCurrency(_ amount: Float) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = formatter.currencySymbol.filter(\.isSymbol)
    formatter.locale = Locale.current
    return formatter.string(from: amount as NSNumber) ?? ""
}

