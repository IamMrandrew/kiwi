//
//  Color.swift
//  Kiwi
//
//  Created by Andrew Li on 9/10/2022.
//


import SwiftUI

extension Color {
    static let accent = Accent()
    static let neutral = Neutral()
    static let additional = Additional()
    
    struct Accent {
        let primary: Color = Color("Primary")
        let onPrimary: Color = Color("On Primary")
    }
    
    struct Neutral {
        let onBackground = Color("On Background")
        let surface = Color("Surface") // Not so accurate, comparing to the system one
        let onSurface = Color("On Surface")
    }
    
    struct Additional {
        let positive: Color = Color("Positive")
    }
}
