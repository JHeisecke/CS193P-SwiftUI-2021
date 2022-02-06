//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

struct MemoryGame<CardsContent> {
    private(set) var cards: [Card<CardsContent>]
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardsContent) {
        cards = [Card<CardsContent>]()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ cards: Card<CardsContent>) {
        
    }
}

struct DeckThemes {
    static let themeVehicles = ["🚙", "🚎", "🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻"]
    static let themeAnimals = ["🐒", "🦅", "🦫", "🦥", "🐿", "🦔", "🦤", "🦁", "🐯"]
    static let themeFood = ["🧋", "🥤", "🍰", "🐒", "🍿", "🍖", "🍗", "🥩", "🍔", "🍟", "🍕"]
}
