//
//  SubViews.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 2/16/23.
//

import Foundation
import SwiftUI


struct SubViews: View {
    
    @ObservedObject var camera: ViewController
    // @EnvironmentObject var sheetManager: SheetManager
    
    var body: some View {
        if camera.isTaken {
            if camera.loading {
                //Loading View
                Text("Loading...") //TODO: Create transparent loading view
            } else {
                //Popup View
//                ZStack {
//                    Text() {
//                        withAnimation(.spring()) {
//                            sheetManager.present(with: .init(item: items[camera.classification]))
//                        }
//                    }
//                }.popup(with: sheetManager)
                EmptyView() //TODO: create popup view to come up on screen
            }
        } else {
            //Button View
            Button (action: {
                camera.takePic();
            }) {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 6)
                        .foregroundColor(.white)
                        .frame(width: 85, height: 85)
                        .padding()
                }
            }
        }
    }
}
