//
//  DeckTheme.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-03-21.
//

import Foundation

extension MemoryGame {
    struct Deck {
        var color: Int
        var name: String
        var cards: [CardContent]
        var numberOfPairs: Int
    }
}

