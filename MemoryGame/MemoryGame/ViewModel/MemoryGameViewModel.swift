//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    
    @Published private var model: MemoryGame = MemoryGame(theme: MemoryThemes.randomOption, numberOfPairs: 20) { pairIndex, theme in
        theme.deck[pairIndex]
    }
    
    var cards: [MemoryGame.Deck.Card] {
        return model.cards
    }
    
    var name: String {
        return model.name
    }
    
    var points: Int {
        return model.points
    }
    
    var color: Int {
        return model.deck.color
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame.Deck.Card) {
        model.choose(card)
    }
}
