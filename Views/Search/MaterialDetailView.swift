//
//  MaterialDetailView.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/26/23.
//

import SwiftUI

struct MaterialDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var palette: ColorPalette {
        return colorScheme == .dark ? .dark : .light
    }
    
    let material: Item
    
    var body: some View {
        
        VStack(spacing: 10) {
            //Image
            if material.url == nil {
                Image(material.name.lowercased())
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
            } else {
                AsyncImage(url: URL(string: material.url!))
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .onAppear {
                        print(material.url ?? "no url found")
                        print(material.id)
                    }
            }
            
            //Text
            Text(material.description)
                .font(.callout)
                .foregroundColor(palette.foregroundColor.opacity(0.8))
        }
        .navigationTitle(material.name)
        .padding()
        

    }
}

struct MaterialDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetailView(material: items[27])
    }
}
