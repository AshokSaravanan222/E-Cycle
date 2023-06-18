//
//  LoadingView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/26/23.
//

import SwiftUI

struct LoadingView: View {
    
    @ObservedObject var camera: ViewController
    
    var body: some View {
        VStack {
            ZStack {
                Color
                    .white
                    .ignoresSafeArea()
                    .opacity(0.2)
                VStack(spacing: 50) {
                    Image(uiImage: camera.displayImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 256.0, height: 256.0)
                        .clipped()
                        .border(.blue)
                    ProgressView()
                        .scaleEffect(3)
                    DisplayText(showText: camera.loading, text: "Processing your photo...")
                }
            }
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(camera: ViewController())
    }
}
