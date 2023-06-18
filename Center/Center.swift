//
//  Location.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/28/23.
//

import Foundation
import SwiftUI

struct Center: Hashable, Codable {
    
    var id: Int
    var address: String
    var call : String = "https://api.earth911.com/earth911.searchLocations?api_key=3bf0f8414175af60"
    
    
}
