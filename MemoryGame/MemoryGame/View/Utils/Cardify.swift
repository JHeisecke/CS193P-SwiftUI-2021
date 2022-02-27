//
//  Cardify.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-27.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.purple)
                content
            } else {
                shape
                    .fill()
                    .foregroundColor(.purple)
            }
        }
    }
}
