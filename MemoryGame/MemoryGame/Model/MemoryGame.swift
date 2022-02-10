//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [MemoryCard]
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = [MemoryCard]()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(MemoryCard(id: pairIndex*2+1, content: content))
            cards.append(MemoryCard(id: pairIndex*2, content: content))
        }
    }
    
    mutating func choose(_ card: MemoryCard) {
        if let chosenIndex = cards.firstIndex(where: {
            $0.id == card.id
        }) {
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    struct MemoryCard: Identifiable {
        var id: Int
        var content: CardContent
        var isFaceUp = false
        var isMatched = false
    }
}

struct DeckThemes {
    static let themeVehicles = ["🚙", "🚎", "🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻"]
    static let themeAnimals = ["🐒", "🦅", "🦫", "🦥", "🐿", "🦔", "🦤", "🦁", "🐯"]
    static let themeFood = ["🧋", "🥤", "🍰", "🐒", "🍿", "🍖", "🍗", "🥩", "🍔", "🍟", "🍕"]
}
