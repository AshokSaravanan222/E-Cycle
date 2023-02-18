//
//  Item.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 1/29/23.
//

import Foundation
import SwiftUI

struct Item: Hashable, Codable {
    var id: Int
    var name: String
    var isRecyclable: Bool
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    
}


