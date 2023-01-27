//
//  RectangleCard.swift
//  LearningAppCWC
//
//  Created by Rohit Singh on 2023-01-26.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10.0)
            .shadow(radius: 5.0)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
