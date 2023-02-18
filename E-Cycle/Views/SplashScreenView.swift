//
//  SplashScreenView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 1/22/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(hex: 0xace8c2, alpha: 1.0).ignoresSafeArea()
                VStack {
                    VStack {
                        Image(uiImage: UIImage(named: "E-Cycle Logo") ?? UIImage())
                            .resizable()
                            .frame(width: 175, height: 175)
                        Text("E-Cycle")
                            .font(Font.custom("norwester", size: 50))
                            .foregroundColor(Color(hex: 0x3D9390, alpha: 1.0))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
