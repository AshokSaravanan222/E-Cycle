////
////  CameraView.swift
////  E-Cycle
////
////  Created by Ashok Saravanan on 1/31/23.
////
//
//import SwiftUI
//
//struct CameraView: View {
//
//    @StateObject var camera = CameraModel()
//    @EnvironmentObject var sheetManager: SheetManager
//
//    var body: some View {
//
//        // going to be camera preview
//        CameraPreview(camera: camera)
//            .ignoresSafeArea(.all, edges: .all)
//
//        HStack {
//
//            if camera.isTaken {
//                ZStack {
//                    Color
//                        .mint
//                        .ignoresSafeArea()
//                    Button("Show Custom Sheet") {
//                        withAnimation(.spring()) {
//                            sheetManager.present(with: .init(item: items[16]))
//                        }
//                    }
//                }
//                .popup(with: sheetManager)
//
//            } else {
//
//                Button (action: camera.takePic, label: {
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 6)
//                            .foregroundColor(.white)
//                            .frame(width: 85, height: 85)
//                            .padding()
//                    }
//                })
//            }
//        }
//        .onAppear(perform: {
//                camera.Check()
//            })
//    }
//
//}
