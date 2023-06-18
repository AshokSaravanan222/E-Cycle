//
//  ColorPalette.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 3/29/23.
//

import Foundation
import SwiftUI

struct ColorPalette {
    let foregroundColor: Color
    let backgroundColor: Color
    
    static let light = ColorPalette(foregroundColor: .black, backgroundColor: .white)
    static let dark = ColorPalette(foregroundColor: .white, backgroundColor: .black)
    
    static func forColorScheme(_ colorScheme: ColorScheme) -> ColorPalette {
        return colorScheme == .dark ? .dark : .light
    }
}
