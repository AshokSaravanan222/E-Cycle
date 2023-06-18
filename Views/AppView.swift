//
//  SubViews.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 2/16/23.
//

import Foundation
import SwiftUI

struct AppView: View {
    
    @ObservedObject var camera: ViewController
    @EnvironmentObject var sheetManager: SheetManager
    
    @State private var appState: AppState = .camera
    
    @State private var store = ItemStore()
    
    var body: some View {
        switch appState {
        case .camera:
            if camera.display {
                VStack {
                    HStack() {
                        VStack(spacing: 20) { // Navigation bar
                            MenuButton(camera: camera, appState: $appState)
                            SearchButton(camera: camera, appState: $appState)
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    CaptureButton(camera: camera)
                }
            } else if camera.loading {
                LoadingView(camera: camera)
            } else {
                popupView
            }
        case .search:
            SearchView(store: store, appState: $appState, camera: camera) {
                Task {
                    do {
                        try await store.save(scrums: store.materials)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        case .menu:
            MenuView(appState: $appState, camera: camera)
        }
    }
}

private extension AppView {
    
    var loadingView: some View {
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
    
    var popupView: some View {
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

