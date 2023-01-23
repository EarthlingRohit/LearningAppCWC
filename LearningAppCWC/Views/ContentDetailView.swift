//
//  ContentDetailView.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-17.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack() {
            // Show video only if we get valid URL.
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10.0)
            }
            // Lesson explanation.
            CodeTextView()
            // Show next lesson button only if there is a next lesson.
            if model.hasNextLesson() {
                Button {
                    // Move to next lesson.
                    model.nextLesson()
                } label: {
                    ZStack() {
                        Rectangle()
                            .frame(height: 48.0)
                            .foregroundColor(.green)
                            .cornerRadius(10.0)
                            .shadow(radius: 5.0)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

/*
 struct ContentDetailView_Previews: PreviewProvider {
 static var previews: some View {
 ContentDetailView()
 }
 }
 */
