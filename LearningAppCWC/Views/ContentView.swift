//
//  ContentView.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-16.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack() {
                // Check whether currentModule is set.
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        NavigationLink(destination: {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index)
                                }
                        }, label: {
                            ContentViewRow(index: index)
                        })
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
