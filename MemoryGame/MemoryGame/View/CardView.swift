//
//  CardView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-19.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.MemoryCard
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusTimeRemaining)*360-90))
                    }
                }
                .foregroundColor(.red)
                .padding(4)
                .opacity(0.5)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}