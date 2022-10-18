//
//  Typography.swift
//  Kiwi Watch App
//
//  Created by Andrew Li on 9/10/2022.
//

import SwiftUI

extension Font {
    static let label = Label()
    
    struct Label {
        let actionButton = Font.system(size: 15).weight(.medium)
        let numpad = Font.system(size: 24, design: .rounded).weight(.medium)
    }
}
