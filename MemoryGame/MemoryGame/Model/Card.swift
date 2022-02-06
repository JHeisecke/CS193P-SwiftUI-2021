//
//  Card.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

class Card<CardContent> {
    var content: CardContent
    
    init(content: CardContent) {
        self.content = content
    }
}

class MemoryCard: Card<Any> {
    var isFaceUp = false
    var isMatched = false
}
