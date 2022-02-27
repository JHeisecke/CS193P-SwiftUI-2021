//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct MemoryGameView: View {
    
    @ObservedObject var viewModel = MemoryGameViewModel()
        
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            memoryGame
        }
    }
    
    var memoryGame: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.MemoryCard
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape
                        .fill()
                        .foregroundColor(.white)
                    shape
                        .stroke(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.purple)
                    Text(card.content).font(font(in: geometry.size))
                } else {
                    shape
                        .fill()
                        .foregroundColor(.purple)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
