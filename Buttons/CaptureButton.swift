//
//  CaptureButton.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/24/23.
//

import SwiftUI

struct CaptureButton: View {
    @ObservedObject var camera: ViewController

    var body: some View {
        HStack {
            //Camera Button
            Spacer()
            Button (action: {
                DispatchQueue.main.async {
                    withAnimation {
                        camera.loading.toggle()
                        camera.stopFeed()
                        camera.display.toggle()
                    }
                }
            }) {
                Circle()
                    .stroke(lineWidth: 6)
                    .foregroundColor(.white)
                    .frame(width: 85, height: 85)
                    .padding()
            }
            Spacer()
        }
    }
}

struct CaptureButton_Previews: PreviewProvider {
    static var previews: some View {
        CaptureButton(camera: ViewController())
            .background(Color.gray)
            .previewLayout(.sizeThatFits)
    }
}
