//
//  E_CycleApp.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 1/22/23.
//

import SwiftUI

@main
struct E_CycleApp: App {
    
    @StateObject var sheetManager = SheetManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//            ContentView()
//                .environmentObject(sheetManager)
            //PopupView()
        }
    }
}
