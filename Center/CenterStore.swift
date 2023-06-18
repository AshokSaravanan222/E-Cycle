//
//  CenterStore.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/31/23.
//

import Foundation

@MainActor
class CenterStore: ObservableObject {
    let baseURL = "https://api.earth911.com/earth911.searchLocations"
    let parameters = [
        "api_key" : "3bf0f8414175af60",
        "latitude" : 1.0,
        "longitude" : 1.2,
        "material_id" : 1,
        "max_results" : 10
    ] as [String : Any]
    
    func fetchDataFromAPI() async throws -> String {
        let baseURL = "https://example.com/api/users"
        let parameters = [
            "id": "123",
            "name": "john"
        ]
        
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Invalid base URL")
        }
        
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            fatalError("Could not create URL from components")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            fatalError("Server error: \(response as? HTTPURLResponse)?.statusCode ?? 0) \n")
        }
        
        if let stringData = String(data: data, encoding: .utf8) {
            return stringData
        } else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data could not be converted to string"])
        }
    }
    
    
}
