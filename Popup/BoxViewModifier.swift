//
//  TransparentBoxViewModifier.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 3/29/23.
//

import Foundation
import SwiftUI

struct TransparentBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            )
    }
}

extension View {
    func transparentBox() -> some View {
            self.modifier(TransparentBox())
        }
}
