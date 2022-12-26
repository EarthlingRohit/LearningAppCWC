//
//  DataService.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2022-12-20.
//

import Foundation

class DataService {
    
    var styleData: Data?
    
    // Function to parse JSON and Style data.
    static func getLocalData() -> [Module] {
        
        // Parse JSON data.
        // Get URL to local JSON file.
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        do {
            // Read JSON file into Data object.
            let jsonData = try Data(contentsOf: jsonUrl!)
            // Decode data with JSON Decoder into an array of modules.
            let jsonDecoder = JSONDecoder()
            let moduleJsonData = try jsonDecoder.decode([Module].self, from: jsonData)
            return moduleJsonData
        } catch {
            print("Error parsing local JSON data: \(error.localizedDescription)")
        }
        
        // Parse Style data.
        // Get URL to local Style file.
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            // Read Style file into Data object.
            let styleData = try Data(contentsOf: styleUrl!)
        } catch {
            print("Error parsing local Style data: \(error.localizedDescription)")
        }
        
        // Return empty array of modules in case creating Data object fails.
        return [Module]()
    }
}
