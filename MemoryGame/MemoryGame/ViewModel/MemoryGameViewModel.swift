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
        MemoryGame<String>(theme: DeckThemes.randomOption) { pairIndex, theme in
            theme.deck[pairIndex]
        }
    }
    
    var cards: [MemoryGame<String>.MemoryCard] {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var name: String {
        return model.name
    }
    
    var color: Int {
        return model.color
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.MemoryCard) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model.name = ""
        model.color = 0
        model = MemoryGameViewModel.createMemoryGame()
    }
}
