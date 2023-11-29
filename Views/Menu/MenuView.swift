//
//  MenuView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 4/22/23.
//

import SwiftUI
import CoreLocationUI

struct MenuView: View {
    
//    var centers : [Center]
    @State private var zipCode : String = "00000"
    @State private var selection : Item = items[0]
    @Binding var appState : AppState
    @ObservedObject var camera : ViewController
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                LocationButton(.currentLocation) {
                  // Fetch location with Core Location.
                }
                .symbolVariant(.fill)
                .labelStyle(.titleAndIcon)
                
                List {
                }
                .navigationTitle("Recyling Centers")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back to Camera") {
                            camera.startFeed()
                            appState = .camera
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.automatic)
            }
        } else {
            // Fallback on earlier versions
        }

    }
}
