//
//  InputDecimalPadView.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 12/11/2022.
//

import SwiftUI

enum DecimalPadButton: Hashable {
    case number(String)
    case delete
    
    var label: String {
        switch self {
        case .number(let number):
            return number
        case .delete:
            return "delete"
        }
    }
    
    var icon: String? {
        switch self {
        case .number(_):
            return nil
        case .delete:
            return "delete.left.fill"
        }
    }
}

struct InputDecimalPadView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: AddEntryViewModel
    @StateObject var inputPadVM: InputDecimalPadViewModel = InputDecimalPadViewModel()
    
    @Binding var amount: String
    
    let addEntry: () -> Void
    @Binding var isDoneAction: Bool
    
    private let decimalPadButtons: [[DecimalPadButton]] = [[.number("1"), .number("2"), .number("3")],
                                                           [.number("4"), .number("5"), .number("6")],
                                                           [.number("7"), .number("8"), .number("9")],
                                                           [.number("."), .number("0"), .delete]]
    
    var body: some View {
        VStack {
            Text(inputPadVM.amount.isEmpty ? "0" : inputPadVM.amount)
                .font(.system(size: 24, weight: .medium))

            Grid(horizontalSpacing: 2,
                 verticalSpacing: 2) {
                ForEach(decimalPadButtons, id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { button in
                            switch button {
                            case .number(let number):
                                InputDecimalPadButton(label: number,
                                                      onButtonPress: inputPadVM.onButtonPress
                                )
                            case .delete:
                                InputDecimalPadButton(label: button.label,
                                                      icon: button.icon,
                                                      onButtonPress: inputPadVM.onButtonPress
                                )
                            }
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
    let icon: String?
    let onButtonPress: (String) -> Void
    
    init(label: String, icon: String? = nil, onButtonPress: @escaping (String) -> Void) {
        self.label = label
        self.icon = icon
        self.onButtonPress = onButtonPress
     }
    
    var body: some View {
        Button {
            onButtonPress(label)
        } label: {
            if let icon = icon {
//              Render the delete button with the specified icon
                Image(systemName: icon)
                    .customInputDecimalPadButtonStyle()
            } else {
//              Render the number button with the text label
                Text(label)
                    .customInputDecimalPadButtonStyle()
            }
        }
        .buttonStyle(.borderless)
    }
}

extension View {
    func customInputDecimalPadButtonStyle() -> some View {
        self
            .font(.label.numpad)
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .foregroundColor(.neutral.onSurface)
            .backgroundColor(.neutral.surface)
            .cornerRadius(8)
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
