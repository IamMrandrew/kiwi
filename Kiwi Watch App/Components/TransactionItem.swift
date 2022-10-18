//
//  TransactionItem.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 14/9/2022.
//

import SwiftUI

struct TransactionItem: View {
    var transaction: TransactionEntity
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(transaction.category?.name ?? "")")
                        .font(.body)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    Text("$\(transaction.amount, specifier: "%.2f")")
                }
                
                Spacer()
                
                Text("🥘")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .foregroundColor(.neutral.onSurface)
        }
    }
}

struct TransactionItem_Previews: PreviewProvider {
    static var previews: some View {
        let previewHelper = PreviewHelper()
        let transactions = previewHelper.fetchTransactions()
        
        TransactionItem(transaction: transactions.first!)
    }
}
