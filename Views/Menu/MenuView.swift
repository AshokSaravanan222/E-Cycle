//
//  MenuView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 4/22/23.
//

import SwiftUI

struct MenuView: View {
    
//    var centers : [Center]
    @State private var zipCode : String = "00000"
    @State private var selection : Item = items[0]
    @Binding var appState : AppState
    @ObservedObject var camera : ViewController
    
    var body: some View {
        TextField("Enter your ZIP code", text: $zipCode)
        Picker("Enter your material: ", selection: $selection) {
            
        }
        .pickerStyle(.inline)
        if #available(iOS 16.0, *) {
            NavigationStack {
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
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
