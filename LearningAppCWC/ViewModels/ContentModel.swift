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
    
    // Current lesson explanation.
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current test.
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current selected content and test.
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        // Parse local JSON data.
        self.modules = DataService.getLocalData()
        // Download and parse remote JSON data.
        DataService.getRemoteData { moduleData in
            self.modules += moduleData
        }
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
        codeText = addStyling(currentLesson!.explanation)
    }
    
    // Function checks for next lesson.
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    // Function to advance to next lesson.
    func nextLesson() {
        // Increase lesson index.
        currentLessonIndex += 1
        // Check whether lesson index is in range.
        if currentLessonIndex < currentModule!.content.lessons.count {
            DispatchQueue.main.async {
                // Set current lesson.
                self.currentLesson = self.currentModule!.content.lessons[self.currentLessonIndex]
                self.codeText = self.addStyling(self.currentLesson!.explanation)
            }
        } else {
            // Reset lesson state.
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    // Function checks for current test.
    func beginTest(_ moduleId: Int) {
        // Set the current module.
        beginModule(moduleId)
        // Set the current question index.
        currentQuestionIndex = 0
        // If there are questions, set the current question as the first question.
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            // Set question content.
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    // Function to advance to next test question.
    func nextQuestion() {
        // Increase question index.
        currentQuestionIndex += 1
        // Check whether question index is in range.
        if currentQuestionIndex < currentModule!.test.questions.count {
            DispatchQueue.main.async {
                // Set current question.
                self.currentQuestion = self.currentModule!.test.questions[self.currentQuestionIndex]
                self.codeText = self.addStyling(self.currentQuestion!.content)
            }
        } else {
            // Reset question state.
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: Code Styling
    // Function to add code styling.
    func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // Add styling data.
        if styleData != nil {
            data.append(styleData!)
        }
        // Add HTML data.
        data.append(Data(htmlString.utf8))
        // Convert to NSAttributedString.
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        return resultString
    }
}
