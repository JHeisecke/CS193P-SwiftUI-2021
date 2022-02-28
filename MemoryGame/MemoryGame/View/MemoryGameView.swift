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
                    .padding(5)
                    .onTapGesture {
                        withAnimation(.spring()) {
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

// MARK: - CardView
struct CardView: View {
    let card: MemoryGame<String>.MemoryCard
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
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
                Text(card.content).font(font(in: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
}
