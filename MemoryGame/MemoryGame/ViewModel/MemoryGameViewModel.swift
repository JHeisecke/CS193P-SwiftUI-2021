//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

class MemoryGameViewModel {
    private var model: MemoryGame<String> = MemoryGame(numberOfPairs: 8) { pairIndex in
        DeckThemes.themeAnimals[pairIndex]
    }
    
    var cards: [Card<String>] {
        return model.cards
    }
}
