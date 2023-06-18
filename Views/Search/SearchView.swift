//
//  SearchView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 4/18/23.
//

import Foundation
import SwiftUI



struct SearchView: View {
    @State private var searchText = ""
    
    @State var store: ItemStore
    @Binding var appState : AppState
    @ObservedObject var camera : ViewController
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()-> Void
    
    var body: some View {
        
        if #available(iOS 16.0, *) {
            NavigationStack {
                List {
                    ForEach(searchResults, id: \.self) { material in
                        NavigationLink(destination: MaterialDetailView(material: material)) { // <- Use NavigationLink to a new view
                            HStack {
                                Text(material.name)
                            }
                        }
                    }
                }
                .navigationTitle("Materials")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Back to Camera") {
                            camera.startFeed()
                            appState = .camera
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    var searchResults: [Item] {
            if searchText.isEmpty {
                return store.materials
            } else {
                return store.materials.filter { $0.name.contains(searchText) }
            }
        }
}
