//
//  CapsuleView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 3/29/23.
//

import Foundation
import SwiftUI

struct MessageCapsule: View {
    @Environment(\.colorScheme) var colorScheme
    var SFSymbolname: String
    var text: String
    var color: Color
    var palette: ColorPalette
    
    var body: some View {
        
        ZStack {
            Capsule()
                .foregroundColor(color.opacity(colorScheme == .light ? 0.2 : 0.8))
                .frame(width: 200, height: 50)
            HStack {
                Image(systemName: SFSymbolname)
                    .symbolVariant(.fill)
                    .font(
                        .system(size: 25,
                                weight: .bold,
                                design: .rounded)
                    )
                    .foregroundColor(palette.foregroundColor)
                Text(text)
                    .bold()
                    .foregroundColor(palette.foregroundColor)
            }
            
        }
    }
}

struct MessageCapsule_Previews: PreviewProvider {
    static var previews: some View {
        MessageCapsule(
            SFSymbolname: "message",
            text: "Hello, world!",
            color: Color.blue,
            palette: ColorPalette(foregroundColor: .black, backgroundColor: .white)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
