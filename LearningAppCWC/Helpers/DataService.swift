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
    
    // Function to get remote JSON data.
    static func getRemoteData() -> [Module] {
        // String path
        let urlString = "https://rohitsocmed.github.io/LearningAppCWC/data2.json"
        // Create URL object.
        let url = URL(string: urlString)
        guard url != nil else {
            // Could not create URL object.
            return
        }
        // Create URL request object.
        let request = URLRequest(url: url!)
        // Get URL Session and start task.
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            // Check for error.
            guard error == nil else {
                return
            }
            do {
                // Decode data with JSON Decoder into an array of modules.
                let decoder = JSONDecoder()
                let modules = try decoder.decode([Module].self, from: data!)
                return modules
            } catch {
                // Could not parse JSON data.
                print("Error parsing remote JSON data: \(error.localizedDescription)")
            }
        }
        // Start data task.
        dataTask.resume()
        // Return empty array of modules in case creating Data object fails.
        return [Module]()
    }
}
