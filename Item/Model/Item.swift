//
//  Item.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 1/29/23.
//

import Foundation
import SwiftUI

struct Item: Hashable, Codable {
    var id: Int // just add 1000 for all new items
    var name: String
    var isRecyclable: Bool // just set to true for other items
    var description: String //use big description or small
    var category: String //make the name of the variable
    var url: String? // if url can be generated use it if not
}


