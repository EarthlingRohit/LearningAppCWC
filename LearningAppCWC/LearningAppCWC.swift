//
//  LearningAppCWC.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2022-12-20.
//

import SwiftUI

@main
struct LearningAppCWC: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
