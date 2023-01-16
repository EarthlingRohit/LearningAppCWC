//
//  ContentViewRow.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-16.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        
        let lesson = model.currentModule!.content.lessons[index]
        // Lesson card.
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .shadow(radius: 5.0)
                .frame(height: 66.0)
            HStack(spacing: 30.0) {
                Text(String(index + 1))
                    .bold()
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding()
        }
        .padding(.bottom, 5.0)
    }
}

/*
 struct ContentViewRow_Previews: PreviewProvider {
 static var previews: some View {
 ContentViewRow()
 }
 }
 */
