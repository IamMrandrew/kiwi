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
    formatter.timeStyle = .medium
    return formatter
}()

func formatIntoCurrency(_ amount: Float) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter.string(from: amount as NSNumber) ?? ""
}

