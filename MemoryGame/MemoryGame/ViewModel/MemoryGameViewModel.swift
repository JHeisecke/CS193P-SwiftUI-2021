//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: 9) { pairIndex in
            DeckTheme.theme[pairIndex]
        }
    }
    
    var cards: [MemoryGame<String>.MemoryCard] {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.MemoryCard) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = MemoryGameViewModel.createMemoryGame()
    }
}
