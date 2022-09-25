//
//  TransactionItem.swift
//  Kiwi
//
//  Created by Andrew Li on 10/9/2022.
//

import SwiftUI

struct TransactionItem: View {
    var transaction: TransactionEntity
    
    var body: some View {
        VStack {
            HStack {
                Text("🥘")
                
                Spacer()
                    .frame(width: 30)
                
                VStack(alignment: .leading) {
                    Text("\(transaction.category?.name ?? "")")
                    
                    Spacer()
                        .frame(height: 4)
                    
                    Text("\(transaction.entryTime!, formatter: transactionDateFormatter)")
                }
                
                Spacer()
                
                Text("$\(transaction.amount, specifier: "%.2f")")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color("Surface"))
            .cornerRadius(8)
        }
    }
}

//struct Transaction_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionItem()
//    }
//}
