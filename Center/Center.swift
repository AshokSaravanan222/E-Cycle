//
//  Location.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/28/23.
//

import Foundation
import SwiftUI

// "https://api.earth911.com/earth911.searchLocations?api_key=3bf0f8414175af60"

struct NearbyCenters: Hashable, Codable {
    let centers: [Center]
    
}

struct Center: Hashable, Codable {
    let address: String
    let description: String
    let materials: [Item]
    let hours: String
    let phone: String
    let website: String
    
}
