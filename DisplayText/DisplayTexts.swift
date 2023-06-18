//
//  DisplayText.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 3/30/23.
//

import Foundation
import SwiftUI

struct TextDisplays {
    
    
    static var welcome: Text { Text("Welcome to E-Cycle!")}
    static var intro: Text { Text("Point the camera at an item and a blue box will appear around it!") }
    static var tip: Text { Text("Try moving the camera back to get the item in frame.") }
    static var loading: Text { Text("Processing your photo...") }
    
}



struct DisplayText: View {
    var showText: Bool
    var text: String

    var body: some View {
        if showText {
                Text(text)
                    .transparentBox()
                    .transition(.opacity)
        } else {
            EmptyView()
        }
        
    }
}

