//
//  SearchButton.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/24/23.
//

import SwiftUI

struct SearchButton: View {
    @ObservedObject var camera: ViewController
    @Binding var appState : AppState
    
    var body: some View {
        Button (action: {
            DispatchQueue.main.async {
                withAnimation {
                    appState = .search
                    camera.stopFeed()
                }
            }
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 60, height: 60)
                    .opacity(0.5)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
        }
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton(camera: ViewController(), appState: .constant(.search))
    }
}
