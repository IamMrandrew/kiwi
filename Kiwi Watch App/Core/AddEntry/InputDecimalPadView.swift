//
//  InputDecimalPadView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 12/11/2022.
//

import SwiftUI

struct InputDecimalPadView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: AddEntryViewModel
    @StateObject var inputPadVM: InputDecimalPadViewModel = InputDecimalPadViewModel()
    
    @Binding var amount: String
    
    let addEntry: () -> Void
    @Binding var isDoneAction: Bool
    
    private let decimalPadButtonLabels = [["1", "2", "3"],
                                          ["4", "5", "6"],
                                          ["7", "8", "9"],
                                          [".", "0", "D"]]
    var body: some View {
        VStack {
            Text(inputPadVM.amount.isEmpty ? "0.00" : inputPadVM.amount)
                .font(.system(size: 24, weight: .medium))

            Grid(horizontalSpacing: 2,
                 verticalSpacing: 2) {
                ForEach(decimalPadButtonLabels, id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { label in
                            InputDecimalPadButton(label: label,
                                                  onButtonPress: inputPadVM.onButtonPress
                            )
                        }
                    }
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    amount = inputPadVM.amount
                    addEntry()
                    isDoneAction = true
                    dismiss()
                }
            }
        })
        .accentColor(.blue)
        .padding(.top, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct InputDecimalPadButton: View {
    let label: String
    let onButtonPress: (String) -> Void
    
    var body: some View {
        Button {
            onButtonPress(label)
        } label: {
            Text(label)
                .font(.label.numpad)
                .frame(height: 32)
                .frame(maxWidth: .infinity)
                .foregroundColor(.neutral.onSurface)
                .backgroundColor(.neutral.surface)
                .cornerRadius(8)
        }
        .buttonStyle(.borderless)
    }
}

struct InputDecimalPadView_Previews: PreviewProvider {
    static var previews: some View {
        InputDecimalPadView(amount: .constant(""),
                            addEntry: {},
                            isDoneAction: .constant(false)
        )
        .environmentObject(AddEntryViewModel())
    }
}
