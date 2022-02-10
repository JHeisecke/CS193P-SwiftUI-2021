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
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
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
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3)
                    .foregroundColor(.purple)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape
                    .fill()
                    .foregroundColor(.purple)
            }
        }
    }
}
