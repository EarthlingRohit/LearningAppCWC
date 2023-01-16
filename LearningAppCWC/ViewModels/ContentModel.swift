//
//  ContentModel.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2022-12-20.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules.
    @Published var modules = [Module]()
    
    // Current module.
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    init() {
        self.modules = DataService.getLocalData()
    }
    
    // Module Navigation methods.
    func beginModule(_ moduleId: Int) {
        // Find index for moduleId.
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                // Found matching module.
                currentModuleIndex = index
                break
            }
        }
        // Set current module.
        currentModule = modules[currentModuleIndex]
    }
}
