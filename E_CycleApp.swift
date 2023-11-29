//
//  E_CycleApp.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 1/22/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct E_CycleApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sheetManager = SheetManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
