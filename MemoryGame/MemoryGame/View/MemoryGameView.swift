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
            Text("Memorize \(viewModel.name)!")
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
                        CardView(card: card, color: viewModel.color)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Spacer()
            HStack {
                VStack {
                    Button {
                        viewModel.newGame()
                    } label: {
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color(hex: viewModel.color))
                            .shadow(radius: 10)
                            .overlay(
                                Image(systemName: "restart")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.black)
                            )
                        
                    }
                    Text("New Game")
                        .font(.caption)
                }
                Spacer()
                Text("Points: \(viewModel.points)")
                Spacer()
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
        MemoryGameView()
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.light)
    }
}

struct CardView: View {
    let card: MemoryGame.Deck.Card
    let color: Int
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3)
                    .foregroundColor(Color(hex: color))
                Text(card.content).font(.largeTitle)
            } else {
                shape
                    .fill()
                    .foregroundColor(Color(hex: color))
            }
        }
    }
}
