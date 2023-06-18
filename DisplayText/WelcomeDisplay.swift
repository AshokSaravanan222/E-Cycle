//
//  Welcome Text.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 3/30/23.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @State private var showWelcomeMessage = false
    
    var body: some View {
        VStack {
            if showWelcomeMessage {
                Text("Welcome to my app!")
                    .foregroundColor(.green)
            }
            Spacer()
            Button("Continue") {
                // Set the UserDefaults value to true
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                
                // Hide the welcome message
                showWelcomeMessage = false
            }
            .padding()
        }
        .onAppear {
            // Check if the user has launched the app before
            if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
                showWelcomeMessage = true
            }
        }
    }
}
