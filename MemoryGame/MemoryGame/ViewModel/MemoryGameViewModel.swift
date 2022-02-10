//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    
    @Published private var model: MemoryGame<String> = MemoryGame(numberOfPairs: 2) { pairIndex in
        DeckThemes.themeAnimals[pairIndex]
    }
    
    var cards: [MemoryGame<String>.MemoryCard] {
        return model.cards
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.MemoryCard) {
        model.choose(card)
    }
}
