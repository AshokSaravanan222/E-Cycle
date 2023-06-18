//
//  CameraPopupView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/26/23.
//

import SwiftUI

struct CameraPopupView: View {
    
    @ObservedObject var sheetManager: SheetManager
    @StateObject var camera: ViewController
    
    var body: some View {
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
}

struct CameraPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPopupView(sheetManager: SheetManager(), camera: ViewController())
    }
}
