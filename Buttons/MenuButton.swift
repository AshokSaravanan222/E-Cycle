//
//  MenuButton.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/24/23.
//

import SwiftUI

struct MenuButton: View {
    @ObservedObject var camera: ViewController
    @Binding var appState : AppState

    var body: some View {
        Button (action: {
            DispatchQueue.main.async {
                withAnimation {
                    appState = .menu
                    camera.stopFeed()
                }
            }
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 60, height: 60)
                    .opacity(0.5)
                Image(systemName: "circle.grid.3x3.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(camera: ViewController(), appState: .constant(.menu))
    }
}
