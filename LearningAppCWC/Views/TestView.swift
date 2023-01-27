//
//  TestView.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-27.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack() {
                // Question number.
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                // Question.
                
                // Answer options.
                
                // Submit button.
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
