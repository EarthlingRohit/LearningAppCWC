//
//  ContentModel.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2022-12-20.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    init() {
        self.modules = DataService.getLocalData()
    }
}
