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
    
    // Current lesson.
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    init() {
        self.modules = DataService.getLocalData()
    }
    
    // MARK: Module Navigation methods.
    
    // Function checks for current module.
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
    
    // Function checks for current lesson.
    func beginLesson(_ lessonId: Int) {
        // Find index for lessonId.
        for index in 0..<currentModule!.content.lessons.count {
            if currentModule!.content.lessons[index].id == lessonId {
                // Found matching lesson.
                currentLessonIndex = index
                break
            }
        }
        // Set current lesson.
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
    }
    
    // Function checks for next lesson.
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    // Function to advance to next lesson.
    func nextLesson() {
        // Increase lesson index.
        currentLessonIndex += 1
        // Check whether lesson index is in range.
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set currentLesson property.
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        } else {
            // Reset lesson state.
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
}
