//
//  ItemStore.swift
//  E-Cycle
//
//  Created by Ashok Saravanan on 5/22/23.
//

import Foundation

@MainActor
class ItemStore: ObservableObject {
    @Published var materials: [Item] = []
    let url = URL(string: "https://api.earth911.com/earth911.getMaterials?api_key=3bf0f8414175af60")!

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("materials.data")
    }

    func load() async throws {
        let task = Task<[Item], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                print("making call to API!")
                
                struct SearchResult: Hashable, Codable {
                    let search_time : String
                    let num_results : Int
                    let result : [Material]
                }

                struct Material: Hashable, Codable {
                    let description : String
                    let url : String
                    let description_legacy : String
                    let material_id : Int
                    let long_description : String
                    let family_ids : [Int]?
                    let image : String
                }
                
                let (data, _) = try await URLSession.shared.data(from: self.url)
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                
                let materials = searchResult.result.map { material in
                    return Item(
                        id: material.material_id + 1000,
                        name: material.description,
                        isRecyclable: true,
                        description: material.long_description,
                        category: material.description_legacy,
                        url: "https://manage.earth911.com/media/" + material.image)
                }
                return materials
            }
            let materials = try JSONDecoder().decode([Item].self, from: data)
            return materials
        }
        let materials = try await task.value
        self.materials = materials
    }

    func save(scrums: [Item]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(materials)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
