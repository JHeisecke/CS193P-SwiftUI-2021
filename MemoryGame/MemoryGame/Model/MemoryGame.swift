//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [MemoryCard]
    
    private var indexOfFlippedCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ( $0 == newValue) } }
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = [MemoryCard]()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(MemoryCard(id: pairIndex*2+1, content: content))
            cards.append(MemoryCard(id: pairIndex*2, content: content))
        }
    }
    
    mutating func choose(_ card: MemoryCard) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let matchCardIndex = indexOfFlippedCard {
                if cards[chosenIndex].content == cards[matchCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchCardIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFlippedCard = chosenIndex
            }
        }
    }
    
    struct MemoryCard: Identifiable {
        let id: Int
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
    }
}

struct DeckThemes {
    static let themeVehicles = ["🚙", "🚎", "🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻"]
    static let themeAnimals = ["🐒", "🦅", "🦫", "🦥", "🐿", "🦔", "🦤", "🦁", "🐯"]
    static let themeFood = ["🧋", "🥤", "🍰", "🐒", "🍿", "🍖", "🍗", "🥩", "🍔", "🍟", "🍕"]
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return first
        } else {
            return nil
        }
    }
}
