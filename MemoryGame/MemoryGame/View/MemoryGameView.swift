//
//  ContentView.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-03.
//

import SwiftUI

struct MemoryGameView: View {
    
    @ObservedObject var viewModel: MemoryGameViewModel
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("Memorize!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                memoryGame
                bottomBar
            }
            deckBody
        }
        .padding()
    }
    
    private func deal(_ card: MemoryGame<String>.MemoryCard) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemoryGame<String>.MemoryCard) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: MemoryGame<String>.MemoryCard) -> Animation {
        var delay =  0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: MemoryGame<String>.MemoryCard) -> Double {
        -Double(viewModel.cards.firstIndex{ $0.id == card.id} ?? 0)
    }
    
    var memoryGame: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .padding(4)
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
                    .transition(.asymmetric(insertion: .scale, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            viewModel.cards.forEach { card in
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var bottomBar: some View {
        HStack {
            Button("Shuffle") {
                withAnimation {
                    viewModel.shuffle()
                }
            }
            Spacer()
            Button("Restart") {
                withAnimation {
                    dealt = []
                    viewModel.restart()
                }
            }
        }.padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        return MemoryGameView(viewModel: game)
            .previewDevice("iPhone 13 Pro Max")
            .preferredColorScheme(.dark)
    }
}
