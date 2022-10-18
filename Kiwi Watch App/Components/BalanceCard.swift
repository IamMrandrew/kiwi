//
//  BalanceCard.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 10/10/2022.
//

import SwiftUI

struct BalanceCard: View {
    let expenses: Float
    let budgetLeft: Float
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Today")
                .font(.headline)
            
            Text(formatIntoCurrency(expenses))
                .font(.title2)
            
            BudgetLeftRow(budgetLeft: budgetLeft)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

struct BudgetLeftRow: View {
    let budgetLeft: Float
    
    var body: some View {
        HStack {
            Image(systemName: "creditcard.circle")
            
            Spacer()
                .frame(width: 2)
            
            Text(formatIntoCurrency(budgetLeft))
        }
        .font(.caption)
        .foregroundColor(.additional.positive)
    }
}

struct BalanceCard_Previews: PreviewProvider {
    static var previews: some View {
        BalanceCard(expenses: -1200.40, budgetLeft: 500.0)
    }
}
