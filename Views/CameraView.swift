//
//  SubViews.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 2/16/23.
//

import Foundation
import SwiftUI


struct CameraView: View {
    
    @ObservedObject var camera: ViewController
    @EnvironmentObject var sheetManager: SheetManager
    
    var body: some View {
        if camera.isTaken {
            if camera.loading {
                //Loading View
                ZStack {
                    Color
                        .white
                        .ignoresSafeArea()
                        .opacity(0.2)
                    ProgressView()
                        .scaleEffect(3)
                }
            } else {
                //Popup View
                ZStack {
                    Color
                        .white
                        .ignoresSafeArea()
                        .opacity(0.2)
                        .onAppear {
                            withAnimation(.spring()) {
                                sheetManager.present(with: .init(item: items[camera.classification]))
                            }
                        }
                }.popup(with: sheetManager, camera: camera)
            }
        } else {
            //Button View
            Button (action: {
                camera.takePic();
            }) {
                VStack {
                    Spacer()
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
