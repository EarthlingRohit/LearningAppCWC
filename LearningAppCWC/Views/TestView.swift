//
//  TestView.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-27.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                // Question number.
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20.0)
                // Question.
                CodeTextView()
                    .padding(.horizontal, 20.0)
                // Answer options.
                ScrollView {
                    VStack() {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button {
                                // Track selected answer's index.
                                selectedAnswerIndex = index
                            } label: {
                                ZStack() {
                                    // Check for color of button based on answer / correct answer.
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48.0)
                                    } else {
                                        // Answer submitted.
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            // User has selected correct answer, show green background for button.
                                            RectangleCard(color: .green)
                                                .frame(height: 48.0)
                                        } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            // User has selected wrong answer, show red background for button.
                                            RectangleCard(color: .red)
                                                .frame(height: 48.0)
                                        } else if index == model.currentQuestion!.correctIndex {
                                            // This button is correct answer, show green background for button.
                                            RectangleCard(color: .green)
                                                .frame(height: 48.0)
                                        } else {
                                            // Other buttons remain white.
                                            RectangleCard(color: .white)
                                                .frame(height: 48.0)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
                // Submit button.
                Button {
                    // After submitted, change 'submitted' to 'true'.
                    submitted = true
                    // Check for correct answer, increment numCorrect counter if correct.
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                } label: {
                    ZStack() {
                        RectangleCard(color: .green)
                            .frame(height: 48.0)
                        Text("Submit")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
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
