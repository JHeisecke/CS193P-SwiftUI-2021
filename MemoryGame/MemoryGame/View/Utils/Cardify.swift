//
//  Cardify.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-27.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var rotation: Double // in degrees
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(CardConstants.color)
                content
            } else {
                shape
                    .fill()
                    .foregroundColor(CardConstants.color)
            }
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}
