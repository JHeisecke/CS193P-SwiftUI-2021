//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Javier Heisecke on 2022-02-06.
//

import Foundation

typealias Card = MemoryGame<String>.Deck.Card

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var areAllCardsMatched: Bool = false
    var name: String
    var color: Int
    var score: Double
    
    private var indexOfFlippedCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach{ cards[$0].isFaceUp = ( $0 == newValue) } }
    }
    
    init(theme: DeckThemes, createCardContent: (Int, DeckThemes) -> CardContent) {
        name = theme.name
        color = theme.color
        cards = [Card]()
        score = 0
        for pairIndex in 0..<theme.numberOfPairs {
            let content = createCardContent(pairIndex, theme)
            cards.append(Card(id: pairIndex*2+1, content: content))
            cards.append(Card(id: pairIndex*2, content: content))
            cards.shuffle()
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let matchCardIndex = indexOfFlippedCard {
                if cards[chosenIndex].content == cards[matchCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchCardIndex].isMatched = true
                    score += (2 + 2 * (cards[matchCardIndex].bonusRemaining + cards[chosenIndex].bonusRemaining)).round(to: 1)
                } else {
                    if cards[chosenIndex].hasBeenSeen ||
                        (cards[chosenIndex].isFaceUp && cards[matchCardIndex].hasBeenSeen) {
                        score -= (1 + 1 * (cards[chosenIndex].negativeBonus + cards[matchCardIndex].negativeBonus)).round(to: 1)
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFlippedCard = chosenIndex
            }
            cards[chosenIndex].hasBeenSeen = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}
